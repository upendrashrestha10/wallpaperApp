import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/widget/widget.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {

  List <PhotoModel> photos = [];
  TextEditingController searchcontroller =  TextEditingController();

  bool search = false;

  Future<void> getsearchWallpaper(String searchQuery) async{
    await http.get(Uri.parse("https://api.pexels.com/v1/search?query=$searchQuery&per_page=100"), 
    headers:{
      "authorization": "G3KIE2bzt2PP5mNqfTYP2NfJUxKRLQKYJrvHHa3SjMMxhzHxK76AkbVK"
      }).then((value){
      Map <String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element){
        PhotoModel photoModel = PhotoModel.fromMap(element);
        photos.add(photoModel);
      });
      setState(() {
        search = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text("Search",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),),

            SizedBox(height: 20,),
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
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: (){
                    getsearchWallpaper(searchcontroller.text);
                  },
                  child:search? GestureDetector(
                    onTap: (){
                      photos = [];
                      search = false;
                      setState(() {
                        
                      });
                    },
                    child: Icon(Icons.close)):Icon(Icons.search_outlined),
                  
                  ) ),
            ),
          ),
          SizedBox(height: 20,),

          Expanded(child: wallpaper(photos, context))
          ],
        ),
      ),
    );
  }
}