import 'package:get/get.dart';
import '../models/album.dart';
import '../models/user.dart';
import '../models/photo.dart';
import '../services/album_service.dart';

class AlbumController extends GetxController {
  var albums = <Album>[].obs; // Observable list of albums
  var users = <int, User>{}.obs; // Observable map of userId to User
  var photos = <int, List<Photo>>{}.obs; // Observable map of albumId to List of Photos
  var isLoading = true.obs; // Observable boolean for loading state

  final AlbumService _albumService = AlbumService();

  @override
  void onInit() {
    super.onInit();
    fetchAlbums();
  }

  // Fetches albums and their corresponding users
  void fetchAlbums() async {
    try {
      isLoading(true);
      var fetchedAlbums = await _albumService.fetchAlbums();
      if (fetchedAlbums.isNotEmpty) {
        albums.assignAll(fetchedAlbums);
        for (var album in fetchedAlbums) {
          var user = await _albumService.fetchUser(album.userId);
          users[album.userId] = user;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch albums: $e');
    } finally {
      isLoading(false);
    }
  }

  // Fetches photos for a given albumId
  void fetchPhotos(int albumId) async {
    print('fetchPhotos method called for albumId: $albumId'); 
    try {
      isLoading(true);
      var fetchedPhotos = await _albumService.fetchPhotos(albumId);

      // Print the fetched photos to verify
      print('Fetched Photos: $fetchedPhotos');

      photos[albumId] = fetchedPhotos;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch photos: $e');
    } finally {
      isLoading(false);
    }
  }
}
