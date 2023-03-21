import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb_project/routes/route.dart';
import 'package:imdb_project/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

void logoutpopup(BuildContext context, String title, IconData icon, String btn1,
    String btn2) {
  void deleteall() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.clear();
  }

  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            height: 210,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Color(0xFFE5B81E), width: 5)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 24.5, left: 10.5, right: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFFE5B81E)),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontFamily: '',
                      ),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 130,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFE5B81E),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        btn1,
                        style: TextStyle(
                            fontFamily: '',
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      deleteall();
                      Get.toNamed(MyRoutes.signinScreen);
                    },
                    child: Container(
                      width: 130,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFFE5B81E),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        btn2,
                        style: TextStyle(
                            fontFamily: '',
                            fontSize: 18,
                            decoration: TextDecoration.none,
                            color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      )),
                    ),
                  ),
                ]),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        );
      });
}
void popup(
    BuildContext context,
    String title,
    IconData icon,
    ) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // Future.delayed(Duration(seconds: 3),(){
        //   Navigator.of(context).pop(true);
        // });
        return Center(
          child: Container(
            height: 200,
            width: MediaQuery.of(context).size.width - 30,
            decoration: BoxDecoration(
              color: ColorConst.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorConst.black),
                  child: Icon(
                    icon,
                    color: ColorConst.white,
                    size: 33,
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,

                   ),
                ),
                SizedBox(
                  height: 5,
                )
              ],
            ),
          ),
        );
      });
}
