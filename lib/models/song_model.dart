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
  final String timestamp;

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
  factory Song.fromMap(
      {required String id, required Map<String, dynamic> map}) {
    return Song(
        id: id,
        songOwnerId: map['songOwnerId'] ?? '',
        songID: map['songID'] ?? '',
        songName: map['songName'] ?? '',
        songGYNumber: map['songGYNumber'] ?? '',
        songTJNumber: map['songTJNumber'] ?? '',
        songJanre: map['songJanre'] ?? '',
        songUtubeAddress: map['songUtubeAddress'] ?? '',
        songETC: map['songETC'] ?? '',
        timestamp: map["timestamp"] ?? "");
  }


  static String? userId;

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
        id,
        songOwnerId,
      ];
}
