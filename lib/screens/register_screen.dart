import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:imdb_project/box.dart';
import 'package:imdb_project/model/register_model.dart';
import 'package:imdb_project/utils/appstring.dart';
import 'package:imdb_project/utils/errors.dart';
import 'package:imdb_project/utils/textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;
  final formGlobalKey = GlobalKey<FormState>();
  static const _keyLoggedIn = 'isLoggedIn';
  @override
  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        elevation: 1,
        title: const Image(
          width: 80,
          image: AssetImage(AppString.logo),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0,left: 18,right: 10,bottom: 10),
              child: Row(
                children: const [
                  Text(
                    AppString.createAccount,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  children: [
                    ///Name TextField
                    textfield(
                      cursorColor: Colors.black,
                      hintText: AppString.name,
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      nextfield: TextInputAction.next,
                      validator: (value) {
                        if (nameController.text.trim().isEmpty) {
                          return ErrorMessage.emptyName;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    ///email textField
                    textfield(
                      cursorColor: Colors.black,
                      hintText: AppString.yourEmail,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      nextfield: TextInputAction.next,
                      validator: (value) {
                        var data = Boxes.getData()
                            .values
                            .toList()
                            .cast<RegisterModel>();
                        var isEmailExist = data.where((element) =>
                        element.email == emailController.text.trim().toString());
                        if (emailController.text.trim().isEmpty) {
                          return ErrorMessage.emptyEmail;
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)) {
                          return ErrorMessage.validEmail;
                        }else if(isEmailExist.isNotEmpty){
                          return ErrorMessage.emailAlreadyRegister;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    ///password textfield
                    textfield(
                      cursorColor: Colors.black,
                      maxLines: 1,
                      hintText: AppString.createPassword,
                      controller: passwordController,
                      obscureText: !_passwordVisible,
                      keyboardType: TextInputType.emailAddress,
                      nextfield: TextInputAction.done,
                      validator: (value) {
                        if (passwordController.text.trim().isEmpty) {
                          return ErrorMessage.emptyPassword;
                        } else if (value!.length < 8) {
                          return ErrorMessage.validPass;
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 13),
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.infoCircle,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(ErrorMessage.validPass)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
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
                        const SizedBox(width: 10,),
                        const Text(
                          AppString.showPassword,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                        width: 600,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.black.withOpacity(0.65))
                        ),
                        child: CupertinoButton(
                            color: Colors.yellow.shade700,
                            borderRadius: BorderRadius.circular(3),
                            child: const Text(
                              AppString.createIdmbAcc,
                              style: TextStyle(
                                  color: Colors.black,
                                  ),
                            ),
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if (formGlobalKey.currentState!.validate()) {
                                final data1 = RegisterModel(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text);
                                final box = Boxes.getData();
                                  box.add(data1);
                                  data1.save();
                                prefs.setString('email', emailController.text.trim());
                                  Get.toNamed(MyRoutes.signinScreen)?.then((value){
                                    nameController.clear();
                                    emailController.clear();
                                    passwordController.clear();
                                  });


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
                            endIndent: 5,
                            indent: 5,
                            color: Colors.black12,
                            thickness: 2,
                          )),
                          Text(
                            AppString.alreadyAcc,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                              child: Divider(
                            endIndent: 5,
                            indent: 5,
                            color: Colors.black12,
                            thickness: 2,
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        width: 600,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(color: Colors.black.withOpacity(0.65))
                        ),
                        child: CupertinoButton(
                            color: const Color(0xffE6E7E7),
                            borderRadius: BorderRadius.circular(3),
                            child: const Text(
                              AppString.signInNow,
                              style: TextStyle(
                                  color: Colors.black,
                                 ),
                            ),
                            onPressed: () {
                              Get.toNamed(MyRoutes.signinScreen);
                            }),
                      ),
                    ),
                  ],
                ),
              ),
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
    );
  }

}
