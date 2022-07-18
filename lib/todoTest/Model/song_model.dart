class SongModel {
  String id;
  String songName;
  String songGYNumber;
  String songTJNumber;
  String songJanre;
  String songUtubeAddress;
  String songETC;
  bool songFavorite;

  SongModel(
    this.id,
    this.songName,
    this.songGYNumber,
    this.songTJNumber,
    this.songJanre,
    this.songUtubeAddress,
    this.songETC,
    this.songFavorite,
  );
  static String? userId;
}
