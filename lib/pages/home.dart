import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List wallpaperimage = [
    "assets/images/wallpaper1.jpeg",
    "assets/images/wallpaper2.jpg",
    "assets/images/wallpaper3.jpg",
    "assets/images/wallpaper4.jpg",
  ];
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            
               Row(
                children: [
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(30),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset("assets/images/me.jpeg", 
                      height: 40, 
                      width: 40, 
                      fit: BoxFit.cover,)
                    ),
                  ),
                  SizedBox(width: 80,),
                  Text("WallMate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),),
                ],
              ),
            
             const SizedBox(height: 30),
             
            CarouselSlider.builder(
              itemCount: wallpaperimage.length, 
              itemBuilder: (context, index, realIndex){
                final res = wallpaperimage[index];
                return buildImage(res, index);
              }, 
              options: CarouselOptions(
                autoPlay: true,
                height: MediaQuery.of(context).size.height/1.5,
                viewportFraction: 1,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                onPageChanged: (index, reason) => setState(() {
                  activeIndex = index;
                }),
              )
            ),

            SizedBox(height: 20,),
            Center(child: buildIndicator()),

          ],
        ),
      ),
    );
  }

  Widget buildIndicator ()=> AnimatedSmoothIndicator(
    activeIndex: activeIndex, 
    count: 4,
    effect:SlideEffect(
      dotWidth: 15, dotHeight: 15,
      activeDotColor: Colors.blue,
    ) ,
  );
  

  Widget buildImage ( String urlImage, int index) => SizedBox(
    height: MediaQuery.of(context).size.height/1.5,
    width: MediaQuery.of(context).size.width,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(urlImage, fit: BoxFit.cover,)
    ),
  );
}