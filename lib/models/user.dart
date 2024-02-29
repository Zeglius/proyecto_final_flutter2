import 'package:flutter/material.dart';
import 'package:proyecto_final_flutter/models/user_posts.dart';
import 'package:proyecto_final_flutter/models/user_story.dart';

class User {
  ImageProvider? avatarImage;
  String username;
  List<UserPosts> userPosts = [];
  UserStory? userStory;

  User({
    this.avatarImage,
    required this.username,
  });
}
