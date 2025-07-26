import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddWallpaper extends StatefulWidget {
  const AddWallpaper({super.key});

  @override
  State<AddWallpaper> createState() => _AddWallpaperState();
}

class _AddWallpaperState extends State<AddWallpaper> {
  final List<String> catagoryitem = ['wildlife', 'Food', 'City', 'Nature'];
  String? value;

  //function for the image picker
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage()async{
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          "Add WallPaper",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            selectedImage == null? GestureDetector(
              onTap: (){
                getImage();
              },
              child: Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 300,
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ):Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 300,
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

            SizedBox(height: 40),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(179, 149, 146, 146),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: catagoryitem
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: ((value) => setState(() {
                    this.value = value;
                  })),
                  hint: Text("Select Catagory"),
                  value: value,
                ),
              ),
            ),

            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Center(
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
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
