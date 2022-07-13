import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final String id;
  final String songOwnerId;
  final String songID;
  final String songName;
  final String songGYNumber;
  final String songTJNumber;
  final String songJanre;
  final String songUtubeAddress;
  final String songETC;
  final Timestamp timestamp;

  const Song(
      {required this.id,
      required this.songOwnerId,
      required this.songID,
      required this.songName,
      required this.songGYNumber,
      required this.songTJNumber,
      required this.songJanre,
      required this.songUtubeAddress,
      required this.songETC,
      required this.timestamp});

  factory Song.fromDoc(DocumentSnapshot<Song> songDoc) {
    final Song songData = songDoc.data()!;
    return Song(
      id: songDoc.data()!.id,
      songID: songData.songID,
      songOwnerId: songData.songOwnerId,
      songName: songData.songName,
      songGYNumber: songData.songGYNumber,
      songTJNumber: songData.songTJNumber,
      songJanre: songData.songJanre,
      songUtubeAddress: songData.songUtubeAddress,
      songETC: songData.songETC,
      timestamp: songData.timestamp,
    );
  }
  factory Song.fromMap(Map<String, dynamic> songDoc) {
    return Song(
      id: songDoc["id"],
      songID: songDoc["songID"],
      songOwnerId: songDoc["songOwnerId"],
      songName: songDoc["songName"],
      songGYNumber: songDoc["songGYNumber"],
      songTJNumber: songDoc["songTJNumber"],
      songJanre: songDoc["songJanre"],
      songUtubeAddress: songDoc["songUtubeAddress"],
      songETC: songDoc["songETC"],
      timestamp: songDoc["timestamp"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'songOwnerId': songOwnerId,
      "songName": songName,
      "songGYNumber": songGYNumber,
      "songTJNumber": songTJNumber,
      "songJanre": songJanre,
      "songUtubeAddress": songUtubeAddress,
      "songETC": songETC,
      'timestamp': timestamp,
    };
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        id,
        songOwnerId,
        songName,
        songGYNumber,
        songTJNumber,
        songJanre,
        songUtubeAddress,
        songETC,
        timestamp
      ];
}
