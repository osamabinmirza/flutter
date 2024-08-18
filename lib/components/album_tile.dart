import 'package:flutter/material.dart';
import '../models/album.dart';
import '../models/user.dart';

class AlbumTile extends StatelessWidget {
  final Album album;
  final User? user;
  final VoidCallback onTap;

  const AlbumTile({
    Key? key,
    required this.album,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(album.title),
      subtitle: Text('User: ${user?.username ?? "Loading..."}'),
      onTap: onTap,
    );
  }
}
