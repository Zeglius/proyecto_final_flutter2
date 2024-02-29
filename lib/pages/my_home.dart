// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:proyecto_final_flutter/mock_data.dart';
import 'package:proyecto_final_flutter/models/user.dart';
import 'package:proyecto_final_flutter/models/user_posts.dart';
import 'package:proyecto_final_flutter/user_story.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Instagram",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          for (final (icon, lambda) in MockData.ICONS_ACTIONS)
            IconButton(
              onPressed: () => lambda,
              icon: Icon(icon),
            )
        ],
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: StreamBuilder<UserStory>(
                  stream: Stream.fromIterable(MockData.USER_STORIES),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          UserStoryWidget(imageUrl: snapshot.data!.image),
                        ],
                      );
                    } else {
                      return Row();
                    }
                  }),
            ),
          ),

          //Card
          for (final user in [
            //NOTE: Put users posts here
            User(username: "username"),
            User(username: "username"),
            User(username: "username"),
          ])
            UserPostsAutoResized(user: user),
        ],
      ),
    );
  }
}

class UserPostsAutoResized extends StatelessWidget {
  const UserPostsAutoResized({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (MediaQuery.sizeOf(context).width > 1000) Spacer(flex: 1),
        Expanded(
          flex: 2,
          child: SizedBox(
            // width: 300,
            child: UserPostWidget(user: user),
          ),
        ),
        if (MediaQuery.sizeOf(context).width > 1000) Spacer(flex: 1),
      ],
    );
  }
}

void _showSnackMsg(BuildContext context, String msg) {
  var messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}

class UserPostWidget extends StatefulWidget {
  final User user;

  final UserPosts? userPosts;

  const UserPostWidget({
    super.key,
    required this.user,
    this.userPosts,
  });

  @override
  State<UserPostWidget> createState() => _UserPostWidgetState();
}

class _UserPostWidgetState extends State<UserPostWidget> {
  bool showCommentWriter = false;
  late FocusNode commentFocusNode;

  @override
  void initState() {
    super.initState();
    commentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        // FIXME: Limit max width for user posts
        width: 200,
        child: Column(
          // User post
          children: [
            PostHeader(),
            Column(
              children: [
                Image.network(
                  "https://i.vimeocdn.com/video/550840522-68f5856f472cdee6ad35a8b43b50e481aa7eb1d653fab342f087d94ba057042f-d_640x337.jpg",
                  fit: BoxFit.contain,
                  width: constraints.minWidth / 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButtonToggle(
                            iconOff: Icon(Icons.favorite_border),
                            iconOn: Icon(Icons.favorite, color: Colors.pink),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                showCommentWriter = !showCommentWriter;
                              });
                              commentFocusNode.requestFocus();
                            },
                            icon: Icon(Icons.chat_bubble_outline),
                          ),
                          Spacer(),
                          IconButtonToggle(
                            onPressed: (data) => _showSnackMsg(
                              context,
                              "${data ? "Added to" : "Removed of"} bookmarks",
                            ),
                            iconOn: Icon(Icons.bookmark),
                            iconOff: Icon(Icons.bookmark_add_outlined),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "x people liked this",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      AnimatedCrossFade(
                        duration: Duration(milliseconds: 200),
                        crossFadeState: showCommentWriter
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: Container(),
                        secondChild: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: const Color.fromRGBO(238, 238, 238, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: LimitedBox(
                                    maxHeight: 80,
                                    child: TextField(
                                      maxLines: null,
                                      focusNode: commentFocusNode,
                                      autocorrect: true,
                                      decoration: InputDecoration.collapsed(
                                        hintText: "Leave a comment",
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.send_outlined))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Padding PostHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Row(
              children: [
                if (widget.user.avatarImage != null)
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    foregroundImage: widget.user.avatarImage,
                  )
                else
                  CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                SizedBox(width: 4),
                Text(widget.user.username),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}

class UserStoryWidget extends StatefulWidget {
  final String imageUrl;

  const UserStoryWidget({super.key, required this.imageUrl});

  @override
  State<UserStoryWidget> createState() => _UserStoryWidgetState();
}

class _UserStoryWidgetState extends State<UserStoryWidget> {
  @override
  Widget build(BuildContext context) {
    final imgUrl = widget.imageUrl;
    return Container(
      /* User story */
      foregroundDecoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.pink,
            width: 2,
          ),
        ),
      ),
      child: CircleAvatar(
        radius: 35,
        foregroundImage: NetworkImage(imgUrl),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class IconButtonToggle extends StatefulWidget {
  final Icon iconOff;
  final Icon iconOn;
  final Function(bool)? onPressed;

  const IconButtonToggle({
    super.key,
    required this.iconOff,
    required this.iconOn,
    this.onPressed,
  });

  @override
  State<IconButtonToggle> createState() => _IconButtonToggleState();
}

class _IconButtonToggleState extends State<IconButtonToggle> {
  bool isFilled = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => setState(() {
        isFilled = !isFilled;
        if (widget.onPressed != null) {
          widget.onPressed!(isFilled);
        }
      }),
      icon: !isFilled ? widget.iconOff : widget.iconOn,
    );
  }
}
