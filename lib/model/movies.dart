class Movie {
  late final String original_title;
  late final String overview;
  late final String poster_path;

  Movie(
    this.original_title,
    this.overview,
    this.poster_path,
  );

  Movie.fromJson(Map<String, dynamic> json) {
    original_title = json['original_title'];
    overview = json['overview'];
    poster_path = json["poster_path"];
  }
}
