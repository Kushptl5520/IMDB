
import 'package:flutter/material.dart';
import 'package:imdb_project/box.dart';
import 'package:imdb_project/model/liked_movie.dart';

class LikeScreen extends StatefulWidget {
  LikeScreen({Key? key,}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {


  @override
  Widget build(BuildContext context) {
    final box = Boxes1.getData();
    final List<LikedMovie> likedMovies = box.values.toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Liked Movie'),
        // actions: [IconButton(onPressed: (){
        //   Hive.box<LikedMovie>('liked_movies').clear();
        // }, icon: Icon(Icons.delete))],
        backgroundColor: Colors.black.withOpacity(0.75),
        elevation: 0,
      ),
      body: Container(
        color: Colors.black.withOpacity(0.95),
        child: ListView.builder(
          itemCount: likedMovies.length,
          itemBuilder: (context, index) {
            final LikedMovie movie = likedMovies[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('⭐ ️${movie.vote_average.toString()}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16)),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.yellow),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(
                                          movie.vote_count.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
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
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}