import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  Future AddWallpaper (Map <String, dynamic> WallPaperInfoMap, String id, String catagory){
    return await FirebaseFirestore.instance.collection()
  }
}