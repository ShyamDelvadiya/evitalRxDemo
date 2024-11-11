import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:untitled/utils/color_constant.dart';

class DialogUtils {
  static showLoader(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: LoadingAnimationWidget.hexagonDots(
                    color: AppColor.whiteColor, size: 50,),
              ),
            ),
          ),
        );
      }),
    );
  }

  static hideLoader(BuildContext context) {
    Navigator.pop(context);
  }

  static showMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(msg),
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }

  static showErrorMessage(BuildContext context, String msg,
      {SnackBarAction? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(msg),
        action: action,
        backgroundColor: Colors.red,
      ),
    );
  }

  static showSnackBarUtil(BuildContext context, Widget child) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: child,
      ),
    );
  }
}
