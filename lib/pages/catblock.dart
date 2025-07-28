import 'package:flutter/material.dart';

class Catblock extends StatefulWidget {
  const Catblock({super.key});

  @override
  State<Catblock> createState() => _CatblockState();
}

class _CatblockState extends State<Catblock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              height: 50,
              width: 100,
              fit: BoxFit.cover,
              "assets/images/food.jpeg"),
          ),

          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black45,
            ),
          ),
          Positioned(
            left: 30,
            top: 15,
            child: Text("Food",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
    );
  }
}