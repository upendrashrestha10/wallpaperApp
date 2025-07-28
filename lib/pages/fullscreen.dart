import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:image_downloader/image_downloader.dart'; 

class Fullscreen extends StatelessWidget {
  final String imgUrl;

  const Fullscreen({super.key, required this.imgUrl});

  Future<void> setWallpaperFromFile(String wallpaperUrl, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Downloading Started...")),
    );

    try {
      // Download the image
      var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
      if (imageId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Download failed!")),
        );
        return;
      }

      // Get path of downloaded image
      var path = await ImageDownloader.findPath(imageId);

      // Show snackbar with open action
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Download Successfully"),
          action: SnackBarAction(
            label: "Open",
            onPressed: () {
              if (path != null) {
                OpenFile.open(path);
              }
            },
          ),
        ),
      );
    } on PlatformException catch (error) {
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error occurred - $error")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imgUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 50,
            right: 50,
            child: ElevatedButton(
              onPressed: () => setWallpaperFromFile(imgUrl, context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text("Download & Open", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
