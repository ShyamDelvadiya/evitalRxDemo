import 'package:flutter/material.dart';
import 'package:untitled/route/route_path.dart';
import 'package:untitled/screen/login_screen/view/login_screen.dart';
import 'package:untitled/utils/pref_constants.dart';
import 'package:untitled/utils/preference_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return _mainView(context);
  }

  Widget _mainView(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return const Column();
  }

  void checkUserLoggedIn() async {
    final bool isUserLogin = getBool(PrefConstants.isUserLoggedIn);
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    if (isUserLogin) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        homeScreen,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        loginScreen,
        (route) => false,
      );
    }
  }
}
