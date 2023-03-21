import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:imdb_project/model/liked_movie.dart';
import 'package:imdb_project/model/register_model.dart';
import 'package:imdb_project/routes/route.dart';
import 'package:imdb_project/screens/home.dart';
import 'package:imdb_project/screens/register_screen.dart';
import 'package:imdb_project/screens/signin_screen.dart';
import 'package:imdb_project/screens/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(RegisterModelAdapter());
  Hive.registerAdapter(LikedMovieAdapter());


  await Hive.openBox<RegisterModel>('registerUser');
  await Hive.openBox<LikedMovie>('liked_movies');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        MyRoutes.signinScreen: (context) => const SigninScreen(),
        MyRoutes.registerScreen: (context) => const RegisterScreen(),
        MyRoutes.homeScreen: (context) => Home(),
      },
    );
  }
}
