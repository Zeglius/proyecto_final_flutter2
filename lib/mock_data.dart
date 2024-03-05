// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyecto_final_flutter/user_story.dart';

import 'models/user.dart';

final class MockData {
  static final List<(IconData, Null Function())> ICONS_ACTIONS = [
    (Icons.favorite_border, () {}),
    (
      Icons.search,
      () => null,
    ),
  ];

  static final List<UserStory> USER_STORIES = [
    UserStory(
      image:
          "https://s.yimg.com/ny/api/res/1.2/b2g8qF8kNn.UvOHgLK6zkg--/YXBwaWQ9aGlnaGxhbmRlcjt3PTk2MDtoPTU0MQ--/https://media-mbst-pub-ue1.s3.amazonaws.com/creatr-uploaded-images/2020-09/a3c03720-f2bf-11ea-9cfd-4ee95e0d7852",
    )
  ];

  // static final List<UserPosts> USER_POSTS = [];

  static List<User> USERS_IN_POSTS = <User>[
    //NOTE: Put users posts here
    User(username: "username"),
    User(username: "username"),
    User(username: "username"),
  ];
}
