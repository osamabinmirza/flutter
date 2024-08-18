import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/album_controller.dart';
import 'screens/albums_screen.dart'; 
import 'screens/album_details_screen.dart';
import 'screens/photo_details_screen.dart';
import 'models/album.dart'; // Import the file where Album is defined
import 'models/photo.dart'; // Import the file where Photo is defined

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AlbumController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Albums App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => AlbumsScreen()),
        GetPage(
          name: '/albumDetails',
          page: () => AlbumDetailsScreen(
            album: Album(
              id: 0,
              title: '',
              userId: 0,
            ),
          ),
        ),
        GetPage(
          name: '/photoDetails',
          page: () => PhotoDetailsScreen(
            photo: Photo(
              albumId: 0,
              id: 0,
              title: '',
              url: '',
              thumbnailUrl: '',
            ),
          ),
        ),
      ],
    );
  }
}
