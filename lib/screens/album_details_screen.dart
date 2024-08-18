import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/album_controller.dart';
import '../models/album.dart';
import 'photo_details_screen.dart';

class AlbumDetailsScreen extends StatelessWidget {
  final Album album;
  final AlbumController albumController = Get.find();

  AlbumDetailsScreen({required this.album});

  @override
  Widget build(BuildContext context) {
    // Trigger fetchPhotos and handle updates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      albumController.fetchPhotos(album.id);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(album.title),
      ),
      body: Obx(() {
        if (albumController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (albumController.photos[album.id] == null || albumController.photos[album.id]!.isEmpty) {
          return Center(child: Text('No photos found'));
        } else {
          final photos = albumController.photos[album.id]!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              print('Photo URL: ${photo.url}');
              return GestureDetector(
                onTap: () {
                  Get.to(() => PhotoDetailsScreen(photo: photo));
                },
                child: Image.network(photo.url, fit: BoxFit.cover),
              );
            },
          );
        }
      }),
    );
  }
}
