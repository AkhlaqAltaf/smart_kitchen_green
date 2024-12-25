import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:smart_kitchen_green_app/PRIVATE_KEYS.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecipeRecommender extends StatefulWidget {
  final String query;
  const RecipeRecommender({super.key, required this.query});

  @override
  State<RecipeRecommender> createState() => _RecipeRecommenderState();
}

class _RecipeRecommenderState extends State<RecipeRecommender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipes Recommended for ${widget.query}")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: YouTubeVideoPage(query: "Different Recipes For ${widget.query}"),
      ),
    );
  }
}

class YouTubeVideoPage extends StatefulWidget {
  final String query;

  YouTubeVideoPage({required this.query});

  @override
  _YouTubeVideoPageState createState() => _YouTubeVideoPageState();
}

class _YouTubeVideoPageState extends State<YouTubeVideoPage> {
  List<Map<String, String>> videos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchYouTubeVideos(widget.query);
  }

  Future<void> fetchYouTubeVideos(String query) async {
    const apiKey = googleApiKey;
    final url =
        'https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=$query&type=video&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          videos = (data['items'] as List).map((item) {
            return {
              "videoId": item['id']['videoId']?.toString() ?? "",
              "title": item['snippet']['title']?.toString() ?? "",
            };
          }).toList();

          isLoading = false;
        });
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error (e.g., show a message to the user)
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (videos.isEmpty) {
      return Center(child: Text("No videos found."));
    }

    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return YouTubeVideoPlayer(
          videoId: videos[index]["videoId"]!,
          title: videos[index]["title"]!,
        );
      },
    );
  }
}

class YouTubeVideoPlayer extends StatelessWidget {
  final String videoId;
  final String title;

  YouTubeVideoPlayer({required this.videoId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId,
              flags: YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.red,
            onReady: () {
              YoutubePlayerController controller = YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(autoPlay: false),
              );
              controller.reset();
            },
          ),
        ],
      ),
    );
  }
}
