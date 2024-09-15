import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:smart_kitchen_green_app/apis/externals/locations.dart';
import '../../../constants.dart';

class HeaderWithSearchBox extends StatefulWidget {
  final Size size;

  HeaderWithSearchBox({
    required this.size,
  });

  @override
  _HeaderWithSearchBoxState createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  String cityName = "Loading...";

  @override
  void initState() {
    super.initState();
    fetchLocation();
  }

  Future<void> fetchLocation() async {
    try {
      LocationData locationData = await getCurrentLocation();
      double latitude = locationData.latitude!;
      double longitude = locationData.longitude!;

      Map<String, dynamic> address = await getCityName(latitude, longitude);
      setState(() {
        cityName = address['city'] + ", " + address['country'];
      });
    } catch (e) {
      setState(() {
        cityName = "Unknown";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      height: widget.size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: widget.size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Hi Akhlaq!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),

                Icon(
                  Icons.location_city,
                  color: Colors.white,
                ),
                Text(
                  " " + cityName,
                  style: TextStyle(color: Colors.white),
                ),

                // Image.asset("assets/plants/images/logo.png"),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SvgPicture.asset("assets/plants/icons/search.svg"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
