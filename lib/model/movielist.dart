class MovieList {
  late final List<dynamic> results;
  late int page;

  MovieList(this.results, this.page);

  MovieList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    results =
        json['results'] != null ? List<dynamic>.from(json['results']) : [];
  }
}
