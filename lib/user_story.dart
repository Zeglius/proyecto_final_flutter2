// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

class UserStory {
  bool isSeen = false;
  final String image;

  void toggleSeen() => isSeen = !isSeen;
  UserStory({required this.image});
}
