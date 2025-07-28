import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/pages/catblock.dart';
import 'package:wallpaper_app/pages/fullscreen.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<PhotoModel> photos = [];
  TextEditingController searchcontroller = TextEditingController();
  bool isSearching = false;

  // Fetch default explore images (e.g., nature)
  Future<void> getExploreImages() async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=nature&per_page=50"),
      headers: {
        "authorization": "G3KIE2bzt2PP5mNqfTYP2NfJUxKRLQKYJrvHHa3SjMMxhzHxK76AkbVK"
      },
    );
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    photos.clear(); // Clear previous
    jsonData["photos"].forEach((element) {
      PhotoModel photoModel = PhotoModel.fromMap(element);
      photos.add(photoModel);
    });
    setState(() {});
  }

  // Fetch search result images
  Future<void> getsearchWallpaper(String searchQuery) async {
    final response = await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$searchQuery&per_page=100"),
      headers: {
        "authorization": "G3KIE2bzt2PP5mNqfTYP2NfJUxKRLQKYJrvHHa3SjMMxhzHxK76AkbVK"
      },
    );
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    photos.clear();
    jsonData["photos"].forEach((element) {
      PhotoModel photoModel = PhotoModel.fromMap(element);
      photos.add(photoModel);
    });
    setState(() {
      isSearching = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getExploreImages(); // Load explore images at start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Se',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'ar',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'ch',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 25),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(179, 108, 82, 82),
              ),
              child: TextField(
                controller: searchcontroller,
                decoration: InputDecoration(
                  hint: Text("search wallpaper"),
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      if (isSearching) {
                        // Clear search and show explore
                        searchcontroller.clear();
                        getExploreImages();
                        setState(() {
                          isSearching = false;
                        });
                      } else {
                        getsearchWallpaper(searchcontroller.text);
                      }
                    },
                    child: Icon(isSearching ? Icons.close : Icons.search_outlined),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    return Catblock();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height * 0.9,
              child: GridView.builder(
                itemCount: photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 400,
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap:(){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>Fullscreen(
                        imgUrl: photos[index].src?.portrait ?? '',))
                    );
                  } ,
                  child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
