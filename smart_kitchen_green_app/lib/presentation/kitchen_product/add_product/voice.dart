import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AddWithVoice extends StatefulWidget {
  const AddWithVoice({super.key});

  @override
  State<AddWithVoice> createState() => _AddWithVoiceState();
}

class _AddWithVoiceState extends State<AddWithVoice> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';
  late TextEditingController _productNameController;
  late TextEditingController _quantityController;
  late TextEditingController _expiryDateController;

  final Map<String, String> _numberWords = {
    'one': '1',
    'two': '2',
    'three': '3',
    'four': '4',
    'five': '5',
    'six': '6',
    'seven': '7',
    'eight': '8',
    'nine': '9',
    'zero': '0',
  };

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _productNameController = TextEditingController();
    _quantityController = TextEditingController();
    _expiryDateController = TextEditingController();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      // Handle the case where the user denied the permission
      print("Microphone permission denied");
    }
  }

  void _listen(TextEditingController controller) async {
    print("ENTER IN ...");
    if (!_isListening) {
      print("LISTENING...");
      bool available = await _speech.initialize(onStatus: (val) {
        print('onStatus: ${val}');
        if (val == "done") {
          setState(() {
            print("LISTEN CHANGE TO FALSE");
            _isListening = false;
          });
        } else {
          print("NOT MATCHED");
        }
      }, onError: (val) {
        print('onError: $val');
        setState(() {
          _isListening = false;
        });
      });
      print("AVAILABLE: $available");
      if (available) {
        print("LISTEN...");
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = _convertToDigits(val.recognizedWords);
            controller.text = _text;
            print("RESULTS PUTTED");
          }),
        );
        print("COMPLETED");
      }
    } else {
      print("LISTENING FALSE OCCUR");
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  String _convertToDigits(String recognizedWords) {
    return recognizedWords
        .split(' ')
        .map((word) => _numberWords[word.toLowerCase()] ?? word)
        .join(' ');
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _quantityController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.text_fields),
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () => _listen(_productNameController),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                prefixIcon: Icon(Icons.numbers),
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () => _listen(_quantityController),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _expiryDateController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: "YYYY-MM-DD",
                labelText: 'Expiry Date (YYYY-MM-DD)',
                prefixIcon: Icon(Icons.date_range),
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () => _listen(_expiryDateController),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle the form submission here
              },
              child: Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
