import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


BuildContext? _progressContext;

void showProgressbarDialog(BuildContext context, {Color? loaderColor}) {
  if (_progressContext == null) {
    showDialog(
        barrierColor: Colors.transparent,
        context: context,
        barrierDismissible: false,
        builder: (con) {
          _progressContext = con;
          return WillPopScope(
              onWillPop: () async => false,
              child: Center(
                child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.30),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: SpinKitCircle(
                          color: loaderColor != null
                              ? loaderColor
                              : Colors.white),
                    )),
              ));
        });
  }
}

void hideProgressDialog() {
  if (_progressContext != null) {
    print("Context Not Null");
    Navigator.of(_progressContext!).pop(true);
    _progressContext = null;
  } else {
    print("Context Null");
  }
}
