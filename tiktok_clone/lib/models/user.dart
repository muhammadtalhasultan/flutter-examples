import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String imageUrl;
  String uid;
  String email;

  User(
      {required this.username,
      required this.imageUrl,
      required this.uid,
      required this.email});

  Map<String, dynamic> toJson() =>
      {'username': username, 'imageUrl': imageUrl, 'uid': uid, 'email': email};

  static User userFromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return User(
      username: snap['username'],
      email: snap['email'],
      uid: snap['uid'],
      imageUrl: snap['imageUrl'],
    );
  }
}
