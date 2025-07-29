import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/photo_model.dart';
import 'package:wallpaper_app/pages/fullscreen.dart';

class AllWallpaper extends StatefulWidget {

  final String catagory;

  const AllWallpaper({super.key, required this.catagory});

  @override
  State<AllWallpaper> createState() => _AllWallpaperState();
}

class _AllWallpaperState extends State<AllWallpaper> {
  List<PhotoModel> photos = [];
  bool isLoading = true;

  final String apiKey = "G3KIE2bzt2PP5mNqfTYP2NfJUxKRLQKYJrvHHa3SjMMxhzHxK76AkbVK";

  @override
  void initState() {
    super.initState();
    fetchCategoryWallpapers(widget.catagory);
  }

  Future<void> fetchCategoryWallpapers(String query) async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=80"),
      headers: {
        "Authorization": apiKey,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      photos.clear();
      jsonData["photos"].forEach((element) {
        PhotoModel photoModel = PhotoModel.fromMap(element);
        photos.add(photoModel);
      });
    } else {
      print("Error fetching category images: ${response.statusCode}");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.catagory,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GridView.builder(
                itemCount: photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 400,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Fullscreen(
                          imagepath: photos[index].src?.portrait ?? '',
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      photos[index].src?.portrait ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
