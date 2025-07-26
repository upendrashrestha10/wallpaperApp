import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/Admin/admin_login.dart';
import 'package:wallpaper_app/pages/bottomnav.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home:AdminLogin(),
    );
  }
}