import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String id;
  String uid;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String profilePhoto;
  String videoUrl;
  String thumbnail;

  Video(
      {required this.caption,
      required this.commentCount,
      required this.id,
      required this.likes,
      required this.profilePhoto,
      required this.shareCount,
      required this.songName,
      required this.thumbnail,
      required this.uid,
      required this.username,
      required this.videoUrl});

  Map<String, dynamic> toJson() => {
        'username': username,
        'caption': caption,
        'id': id,
        'uid': uid,
        'commentCount': commentCount,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'shareCount': shareCount,
        'songName': songName,
        'thumbnail': thumbnail,
        'videoUrl': videoUrl,
      };

  static Video fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return Video(
        caption: snap['caption'],
        commentCount: snap['commentCount'],
        id: snap['id'],
        likes: snap['likes'],
        profilePhoto: snap['profilePhoto'],
        shareCount: snap['shareCount'],
        songName: snap['songName'],
        thumbnail: snap['thumbnail'],
        uid: snap['uid'],
        username: snap['username'],
        videoUrl: snap['videoUrl']);
  }
}
