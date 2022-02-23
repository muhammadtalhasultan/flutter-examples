import 'package:flutter/material.dart';
import 'package:tiktok_clone/data/data.dart';
import 'package:tiktok_clone/screens/screens.dart';
import 'package:tiktok_clone/widgets/circle_animation.dart';
import 'package:tiktok_clone/widgets/video_player_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color color = Colors.white;

  likeBtn(index) {
    setState(() {
      if (videos[index].likes.contains(videos[index].uid)) {
        videos[index].likes.remove(videos[index].uid);
      } else {
        videos[index].likes.add(videos[index].uid);
      }
    });
  }

  goToComment(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const CommentScreen())));
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: AssetImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: AssetImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 2,
            left: 23,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 8,
              child: Icon(
                Icons.add,
                size: 10,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          itemCount: videos.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                VideoPlayerItem(
                  videoUrl: videos[index].videoUrl,
                ),
                Column(
                  children: [
                    const SizedBox(height: 100),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    videos[index].username,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    videos[index].caption,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Icon(Icons.music_note, size: 15),
                                      Text(
                                        videos[index].songName,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                buildProfile(videos[index].profilePhoto),
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                            onTap: () => {likeBtn(index)},
                                            child: Icon(
                                              Icons.favorite,
                                              size: 30,
                                              color:
                                                  videos[index].likes.isNotEmpty
                                                      ? Colors.red
                                                      : Colors.white,
                                            )),
                                        Text(videos[index]
                                            .likes
                                            .length
                                            .toString())
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    InkWell(
                                      onTap: () => {goToComment(context)},
                                      child: Column(
                                        children: [
                                          const Icon(Icons.comment, size: 30),
                                          Text(videos[index]
                                              .commentCount
                                              .toString())
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          const Icon(Icons.reply, size: 30),
                                          Text(videos[index]
                                              .shareCount
                                              .toString())
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    CircleAnimation(
                                      child: buildMusicAlbum(
                                          videos[index].profilePhoto),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
