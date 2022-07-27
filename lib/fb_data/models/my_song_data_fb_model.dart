import 'package:cloud_firestore/cloud_firestore.dart';

class MySongDataFirebase {
  String? id;
  String songOwnerId;
  String songName;
  String songGYNumber;
  String songTJNumber;
  String songJanre;
  String songUtubeAddress;
  String songETC;

  MySongDataFirebase(
    this.id,
    this.songOwnerId,
    this.songName,
    this.songGYNumber,
    this.songTJNumber,
    this.songJanre,
    this.songUtubeAddress,
    this.songETC,
  );

  MySongDataFirebase.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id,
        songOwnerId = snapshot["songOwnerId"],
        songName = snapshot["songName"],
        songGYNumber = snapshot["songGYNumber"],
        songTJNumber = snapshot["songTJNumber"],
        songJanre = snapshot["songJanre"],
        songUtubeAddress = snapshot["songUtubeAddress"],
        songETC = snapshot["songETC"];

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id,
      "songOwnerId": songOwnerId,
      "songName": songName,
      "songGYNumber": songGYNumber,
      "songTJNumber": songTJNumber,
      "songJanre": songJanre,
      "songUtubeAddress": songUtubeAddress,
      "songETC": songETC,
    };
  }
}
