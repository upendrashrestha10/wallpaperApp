import 'package:flutter/material.dart';



class Fullscreen extends StatelessWidget {

  String imgUrl;
  
Fullscreen({super.key, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(imgUrl),
          fit: BoxFit.cover),
        ),
      ),
    );
  }
}