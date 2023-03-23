import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imdb_project/box.dart';
import 'package:imdb_project/model/liked_movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikeScreen extends StatefulWidget {
  LikeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {

  List<LikedMovie> likeMovieList = [];
  var isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getAllLikeMoviesList();
  }

  void getAllLikeMoviesList()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final box = Boxes1.getData();
    final data = box.values.toList();
    final likedMovies = data.where((element)=> element.email == prefs.getString('email'));
     setState(() {
       likeMovieList  = likedMovies.toList();
       isDataLoaded = true;
     });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favourite Movie'),
        actions: [
          IconButton(
              onPressed: (){

          setState(() {
            Hive.box<LikedMovie>('liked_movies').clear();
            likeMovieList.clear();

          });
        },
              icon: Icon(Icons.delete))],
        backgroundColor: Colors.black.withOpacity(0.75),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black.withOpacity(0.95),
        child: isDataLoaded ? likeMovieList.isEmpty
            ? Center(
                child: Text(
                'No movie added',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ))
            : ListView.builder(
                itemCount: likeMovieList.length,
                itemBuilder: (context, index) {
                  final box = Boxes1.getData();
                  final data = box.get(likeMovieList[index].id);
                  final LikedMovie movie = likeMovieList[index];
                  print(likeMovieList[index].id);
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 10),
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              height: 160,
                              width: 150,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    movie.release_date.toString(),
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    movie.original_language.toString(),
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              '⭐ ️${movie.vote_average.toString()}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16)),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.yellow),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(1.0),
                                              child: Text(
                                                movie.vote_count.toString(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  // if(movie.id == movie.id){
                                  //   movie.like = true;
                                  // }
                                  print(movie.id);
                                  setState(() {
                                    box.delete(movie.id);
                                    likeMovieList.removeAt(index);
                                    movie.isLike = false;
                                  });
                                },
                                icon: Icon(
                                    movie.isLike! ?  Icons
                                        .favorite: Icons.favorite_border,
                                    color: Colors
                                        .yellow))
                          ],
                        ),

                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                    ],
                  );
                },
              ) : Container(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                ),
        ),
      ),
    );
  }
}
