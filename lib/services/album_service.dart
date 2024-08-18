import 'package:dio/dio.dart';
import '../../models/album.dart';
import '../../models/user.dart';
import '../../models/photo.dart';

class AlbumService {
  final Dio _dio = Dio();
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> fetchAlbums() async {
    try {
      final response = await _dio.get('$baseUrl/albums');
      return (response.data as List)
          .map((album) => Album.fromJson(album))
          .toList();
    } catch (e) {
      throw Exception('Failed to load albums: $e');
    }
  }

  Future<User> fetchUser(int userId) async {
    try {
      final response = await _dio.get('$baseUrl/users/$userId');
      return User.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  Future<List<Photo>> fetchPhotos(int albumId) async {
  try {
    final response = await _dio.get('$baseUrl/photos?albumId=$albumId');
    List<Photo> photos = (response.data as List)
        .map((photo) => Photo.fromJson(photo))
        .toList();
    print('Raw photo data: ${response.data}');
    print('Photos fetched: ${photos.map((p) => p.toJson()).toList()}');
    return photos;
  } catch (e) {
    throw Exception('Failed to load photos: $e');
  }
}

}
