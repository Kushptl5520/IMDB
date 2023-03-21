import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imdb_project/routes/route.dart';
import 'package:imdb_project/utils/appstring.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Splash1 splashScreen = Splash1();

  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(0xFFE5B81E)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage(AppString.logo),
              width: 150,
            ),
          ),
        ],
      ),
    ));
  }
}

class Splash1 {
  void isLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('email'));
    if (prefs.getString('email') == prefs.getString('email')) {
      Timer(Duration(seconds: 3), () => Get.toNamed(MyRoutes.homeScreen));
    }
    if (prefs.getString('email') == null) {
      Timer(Duration(seconds: 3), () => Get.toNamed(MyRoutes.signinScreen));
    }
    // var data = Boxes.getData();
    //   if (data.isEmpty) {
    //     Timer(Duration(seconds: 3), () => Get.toNamed(MyRoutes.signinScreen));
    //   } else {
    //     Timer(Duration(seconds: 3), () => Get.toNamed(MyRoutes.homeScreen));
    //   }
    // }}
  }

}