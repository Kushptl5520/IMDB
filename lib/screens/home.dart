import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:imdb_project/box.dart';
import 'package:imdb_project/model/Results.dart';
import 'package:imdb_project/model/liked_movie.dart';
import 'package:imdb_project/screens/like_movie.dart';
import 'package:imdb_project/utils/popup.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool hasMore = true;
  bool isFirstLoad = true;
  List<Results> movieList = [];
  final searchController = TextEditingController();
  int _page = 1;
  List<LikedMovie> _likedMovies = [];
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Movies'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LikeScreen()));
                  },
                  icon: Icon(Icons.favorite, color: Colors.white)),
              IconButton(
                  onPressed: () {
                    logoutpopup(context, 'Are you sure you want to logout?',
                        Icons.logout, 'No', 'Yes');
                  },
                  icon: const Icon(Icons.logout)),
            ],
            backgroundColor: Colors.black.withOpacity(0.75),
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            color: Colors.black.withOpacity(0.95),
            child: isLoading && isFirstLoad
                ? Center(
                    child: SpinKitCircle(
                      color: Colors.white,
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width - 20,
                                  height: 50,
                                  child: CupertinoSearchTextField(
                                    controller: searchController,
                                    onSuffixTap: () => _resetMovies(),
                                    prefixIcon: Container(),
                                    itemColor: Colors.white,
                                    onSubmitted: (_) {
                                      setState(() {
                                        movieList.clear();
                                        isFirstLoad = true;
                                        _page = 1;
                                      });
                                      getPopularMovies();
                                    },
                                    style: TextStyle(color: Colors.white),
                                    placeholderStyle: TextStyle(
                                        color: Colors.grey, fontSize: 19),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.white),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (searchController.text.trim().isEmpty) {
                                  return;
                                }
                                setState(() {
                                  movieList.clear();
                                  isFirstLoad = true;
                                });
                                getPopularMovies();
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.yellow.shade700,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Flexible(
                        child: Stack(
                          children: [
                            ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: _scrollController,
                              itemCount: movieList.length + (hasMore ? 1 : 0),
                              itemBuilder: (BuildContext context, index) {
                                if (index == movieList.length && hasMore) {
                                  return Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: SpinKitCircle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                } else {
                                  final movie = movieList[index];
                                  return Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 10, top: 10),
                                        color: Colors.transparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            movie.imagePath == null
                                                ? Image(
                                                    image: NetworkImage(
                                                        'https://cdn0.iconfinder.com/data/icons/small-v8/512/photo_polaroid_picture_shot_instant-512.png'),
                                                    height: 160,
                                                    width: 150,
                                                    color: Colors.white,
                                                  )
                                                : FadeInImage(
                                                    image: NetworkImage(
                                                        movie.getPosterUrl()),
                                                    height: 160,
                                                    width: 150,
                                                    placeholder: AssetImage(
                                                        'assets/images/loader.gif'),
                                                  ),
                                            Flexible(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    movie.title.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    movie.release_date
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    movie.original_language
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              '⭐ ️${movie.vote_average.toString()}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16)),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color: Colors
                                                                        .yellow),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1.0),
                                                              child: Text(
                                                                movie.vote_count
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      IconButton(
                                                          onPressed: () {
                                                            if (_selectedIndex ==
                                                                index) {
                                                              _selectedIndex =
                                                                  -1;
                                                            } else {
                                                              _selectedIndex =
                                                                  index;

                                                            }
                                                            addLikedMovie(
                                                                movie);
                                                          },
                                                          icon: Icon(
                                                            index ==
                                                                    _selectedIndex
                                                                ? Icons.favorite
                                                                : Icons
                                                                    .favorite_border,
                                                            color: index ==
                                                                    _selectedIndex
                                                                ? Colors.yellow
                                                                : Colors.white,
                                                          ))
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
                                }
                              },
                            ),
                            if (movieList.isEmpty)
                              Center(
                                child: Text(
                                  'No data found !!!',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
            // floatingActionButton: FloatingActionButton(
            //   backgroundColor: Colors.yellow.shade700,
            //   onPressed: () {
            //     _scrollController.animateTo(0,
            //         duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
            //   },
            //   child: Icon(Icons.arrow_upward),
            // ),
          ),
        ));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> getPopularMovies() async {
    setState(() {
      isLoading = true;
    });
    String? url;
    if (searchController.text.isEmpty) {
      url =
          'https://api.themoviedb.org/3/movie/popular?api_key=b4a549abb798b19dbb7e63335d135053&page=${movieList.length ~/ 20 + _page}';
    } else {
      url =
          'https://api.themoviedb.org/3/search/movie?api_key=b4a549abb798b19dbb7e63335d135053&query=${searchController.text.trim()}&page=${movieList.length ~/ 20 + _page}';
    }
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];

      List<Results> movies = [];

      for (var result in results) {
        final movie = Results.fromJson(result);
        movies.add(movie);
      }

      setState(() {
        if (isFirstLoad) {
          movieList = movies;
          isFirstLoad = false;
        } else {
          movieList.addAll(movies);
        }
        isLoading = false;
        hasMore = jsonData['page'] < jsonData['total_pages'];
      });
    } else {
      throw Exception('Failed to load movies');
    }
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!isLoading && hasMore) {
        getPopularMovies();
      }
    }
  }

  Future<void> _resetMovies() async {
    setState(() {
      searchController.clear();
      isLoading = true;
      hasMore = true;
      isFirstLoad = true;
      _page = 1;
      movieList.clear();
    });

    await getPopularMovies();
  }

  Future<bool> showExitPopup() async {
    return await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  void _loadLikedMovies() async {
    final likedMoviesBox = Boxes1.getData();
    final List<LikedMovie> likedMovies = likedMoviesBox.values.toList();
    setState(() {
      _likedMovies = likedMovies;
    });
  }

  Future<void> addLikedMovie(Results movie) async {
    final LikedMovie likedMovie = LikedMovie(
      id: movie.id,
      title: movie.title,
      posterPath: movie.imagePath,
      original_language: movie.original_language,
      release_date: movie.release_date,
      vote_average: movie.vote_average,
      vote_count: movie.vote_count,
    );
    final box = Boxes1.getData();
    if (!box.containsKey(movie.id)) {
      box.put(movie.id, likedMovie);
    } else {
      box.delete(movie.id);
    }
    _loadLikedMovies();
  }
}
