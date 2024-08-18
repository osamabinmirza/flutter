import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/album_controller.dart';
import '../components/album_tile.dart';
import 'album_details_screen.dart';

class AlbumsScreen extends StatelessWidget {
  final AlbumController albumController = Get.put(AlbumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Obx(() {
        if (albumController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (albumController.albums.isEmpty) {
          return Center(child: Text('No albums found'));
        } else {
          return ListView.builder(
            itemCount: albumController.albums.length,
            itemBuilder: (context, index) {
              final album = albumController.albums[index];
              final user = albumController.users[album.userId];
              return AlbumTile(
                album: album,
                user: user,
                onTap: () {
                  Get.to(() => AlbumDetailsScreen(album: album));
                },
              );
            },
          );
        }
      }),
    );
  }
}
