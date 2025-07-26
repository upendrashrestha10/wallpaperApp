import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/bottomnav.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final GlobalKey <FormState> _formkey = GlobalKey <FormState>();
  TextEditingController usernamecontroller = TextEditingController();

  TextEditingController userpasswordcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
              padding: EdgeInsets.only(top: 40, right: 20, left: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(MediaQuery.of(context).size.width, 110),
                ) , 
              ),
            ),
          
          Container(
            margin: EdgeInsets.only(top: 60, right: 30, left: 30),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text("Let's start with \n Admin",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),),

SizedBox(height: 30,),

                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: MediaQuery.of(context).size.height/2.2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5, left: 20),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 202, 140, 140),
                              ),
                              borderRadius: BorderRadius.circular(20)
                            ),

                            child: Center(
                              child: TextFormField(
                                controller: usernamecontroller,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please Enter User name";
                                  }
                                },

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "username",
                                  hintStyle: TextStyle(
                                    color: const Color.fromARGB(255, 202, 140, 140),
                                  )
                                ),
                              ),
                            ),
                          ),

SizedBox(height: 20,),

                           Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5, left: 20),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 202, 140, 140),
                              ),
                              borderRadius: BorderRadius.circular(20)
                            ),

                            child: Center(
                              child: TextFormField(
                                controller: userpasswordcontroller,
                                validator: (value){
                                  if(value == null || value.isEmpty){
                                    return "Please Enter Password";
                                  }
                                },

                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: const Color.fromARGB(255, 202, 140, 140),
                                  )
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 40,),

                          GestureDetector(
                            onTap: (){
                              loginAdmin();
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
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  )
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
          )
          ],
        ),
      ),

    );
  }

  loginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
      snapshot.docs.forEach((result){
        if(result.data()['id']!= usernamecontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Your id is not correct", 
              style: TextStyle(
                fontSize: 20),
            ),
          ));
        }

        if(result.data()['password']!= userpasswordcontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Your password is not correct", 
              style: TextStyle(
                fontSize: 20),
            ),
          ));
        }else{
          Route route = MaterialPageRoute(builder: (context)=> BottomNav() );
          Navigator.pushReplacement(context, route);
        }
      });
    });
  }
}