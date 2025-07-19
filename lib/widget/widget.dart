import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photo_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget wallpaper(List<PhotoModel> listPhotos, BuildContext context){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      padding: EdgeInsets.all(4),
      crossAxisCount: 2, 
      childAspectRatio: 0.6, 
      mainAxisSpacing: 6, 
      crossAxisSpacing: 6,

      children: [
        ...listPhotos.map((PhotoModel photoModel){
          return GridTile(
            child: Hero(
              tag: photoModel.src?.portrait ?? "",
              child: Container(
               child: CachedNetworkImage(
                imageUrl: photoModel.src?.portrait ?? "",
                fit: BoxFit.cover,
              ),

          )),);
        }),
      ],
    ),
  );
}