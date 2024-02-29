import 'package:proyecto_final_flutter/models/user.dart';

class UserPosts {
  final User poster;
  List<String> whoLiked = [];
  final String postImg;

  UserPosts({required this.poster, required this.postImg});
}
