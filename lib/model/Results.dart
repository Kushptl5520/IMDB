class Results {
  final String? title;
  final String? overview;
  final String? imagePath;
  var vote_average;
  var vote_count;
  var release_date;
  var original_language;
  var id;

  Results({
    this.original_language,
    this.overview,
    this.imagePath,
    this.release_date,
    this.title,
    this.vote_average,
    this.vote_count,
    this.id,
  });

  factory Results.fromJson(Map<String,dynamic>json) {
    return Results(
      original_language: json['original_language'],
      overview: json['overview'],
      imagePath: json['poster_path'],
      release_date: json['release_date'],
      title: json['title'],
      vote_average: json['vote_average'],
      vote_count: json['vote_count'],
      id: json['id']
    );
  }
  String getPosterUrl() {
    return 'https://image.tmdb.org/t/p/w200$imagePath';
  }
}
