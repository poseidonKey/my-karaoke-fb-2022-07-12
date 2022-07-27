import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Song extends Equatable {
  String? id;
  String songOwnerId;
  String songName;
  String songGYNumber;
  String songTJNumber;
  String songJanre;
  String songUtubeAddress;
  String songETC;

  Song(
    this.id,
    this.songOwnerId,
    this.songName,
    this.songGYNumber,
    this.songTJNumber,
    this.songJanre,
    this.songUtubeAddress,
    this.songETC,
  );
  static String? userId;
  Song.fromMap(QueryDocumentSnapshot snapshot)
      : id = snapshot.id,
        songOwnerId = snapshot["songOwnerId"],
        songName = snapshot["songName"],
        songGYNumber = snapshot["songGYNumber"],
        songTJNumber = snapshot["songTJNumber"],
        songJanre = snapshot["songJanre"],
        songUtubeAddress = snapshot["songUtubeAddress"],
        songETC = snapshot["songETC"];

  // factory Song.fromDoc(DocumentSnapshot<Object?> songDoc) {
  //   final Song songData = songDoc.data()! as Song;
  //   return Song(
  //     id: songDoc.id,
  //     songID: songData.songID,
  //     songOwnerId: songData.songOwnerId,
  //     songName: songData.songName,
  //     songGYNumber: songData.songGYNumber,
  //     songTJNumber: songData.songTJNumber,
  //     songJanre: songData.songJanre,
  //     songUtubeAddress: songData.songUtubeAddress,
  //     songETC: songData.songETC,
  //     timestamp: songData.timestamp,
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'songOwnerId': songOwnerId,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id!,
        songOwnerId,
      ];
}
