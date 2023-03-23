import 'package:hive/hive.dart';

part 'liked_movie.g.dart';

@HiveType(typeId: 1)
class LikedMovie {
  @HiveField(0)
  var id;

  @HiveField(1)
  var title;

  @HiveField(2)
  var posterPath;

  @HiveField(3)
  var release_date;

  @HiveField(4)
  var original_language;

  @HiveField(5)
  var vote_average;

  @HiveField(6)
  var vote_count;

  @HiveField(7)
  var email;

  @HiveField(8)
  bool? isLike = false;

  LikedMovie({this.id, this.title,  this.posterPath,this.original_language,this.vote_count,this.release_date,this.vote_average,this.email,this.isLike});
}