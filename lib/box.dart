import 'package:hive/hive.dart';
import 'package:imdb_project/model/liked_movie.dart';
import 'package:imdb_project/model/register_model.dart';

class Boxes{
  static Box<RegisterModel> getData()=> Hive.box<RegisterModel>('registerUser');
}
class Boxes1{
  static Box<LikedMovie> getData()=> Hive.box<LikedMovie>('liked_movies');
}