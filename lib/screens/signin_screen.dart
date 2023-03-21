
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb_project/box.dart';
import 'package:imdb_project/model/register_model.dart';
import 'package:imdb_project/routes/route.dart';
import 'package:imdb_project/utils/appstring.dart';
import 'package:imdb_project/utils/errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _passwordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email;

  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white38,
          elevation: 1,
          title: const Image(
            width: 80,
            image: AssetImage(AppString.logo),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, left: 20, right: 10, bottom: 10),
                child: Row(
                  children: const [
                    Text(
                      AppString.signIn,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      AppString.forgotPass,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.65)),
                          borderRadius: BorderRadius.circular(3)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: AppString.email,
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.black.withOpacity(0.35),
                          ),
                          SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: !_passwordVisible,
                                textInputAction: TextInputAction.done,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: AppString.imdbPassword,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.transparent),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 10),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        child: Icon(
                          _passwordVisible
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: Colors.black,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      AppString.showPassword,
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border:
                          Border.all(color: Colors.black.withOpacity(0.65))),
                  child: CupertinoButton(
                      color: Colors.yellow.shade700,
                      borderRadius: BorderRadius.circular(3),
                      child: const Text(
                        AppString.signIn,
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: ()async {
                        var data = Boxes.getData()
                            .values
                            .toList()
                            .cast<RegisterModel>();

                        var isEmailExist = data.where((element) =>
                            element.email == emailController.text.toString());
                        var isPasswordExist = data.where((element) =>
                            element.password ==
                            passwordController.text.toString());
                        if (emailController.text.trim().isEmpty) {
                          Get.snackbar(
                            'Error',
                            ErrorMessage.emptyEmail,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (isEmailExist.isEmpty) {
                          Get.snackbar(
                            'Error',
                            ErrorMessage.userNotFound,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (passwordController.text.trim().isEmpty) {
                          Get.snackbar(
                            'Error',
                            ErrorMessage.emptyPassword,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else if (isPasswordExist.isEmpty) {
                          Get.snackbar(
                            'Error',
                            ErrorMessage.incorrectPass,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                        else {
                          Get.toNamed(MyRoutes.homeScreen);
                        }
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: const [
                    Expanded(
                        child: Divider(
                      endIndent: 10,
                      indent: 20,
                      color: Colors.black12,
                      thickness: 2,
                    )),
                    Text(
                      AppString.newToImdb,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                        child: Divider(
                      endIndent: 20,
                      indent: 10,
                      color: Colors.black12,
                      thickness: 2,
                    )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border:
                          Border.all(color: Colors.black.withOpacity(0.65))),
                  child: CupertinoButton(
                      color: const Color(0xffE6E7E7),
                      borderRadius: BorderRadius.circular(3),
                      child: const Text(
                        AppString.createNewAcc,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(MyRoutes.registerScreen);
                      }),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Divider(
                endIndent: 50,
                indent: 50,
                color: Colors.black12,
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      AppString.condition,
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      AppString.privacyPolicy,
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  AppString.footer,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
