import 'package:flutter/material.dart';
import 'package:untitled/common_widgets/common_bottom_background.dart';
import 'package:untitled/common_widgets/common_home_background.dart';
import 'package:untitled/route/route_path.dart';
import 'package:untitled/utils/color_constant.dart';
import 'package:untitled/utils/pref_constants.dart';
import 'package:untitled/utils/preference_utils.dart';
import 'package:untitled/utils/size_constant.dart';
import 'package:untitled/utils/string_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationConfiguration();
    checkUserLoggedIn();
  }


  @override
  Widget build(BuildContext context) {
    return _mainView(context);
  }

  Widget _mainView(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.blackColor,
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Stack(
      children: [
        const CommonHomeBackground(),
        const CommonBottomBackground(),
        Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringConstant.splashScreenTitle,
                  style: TextStyle(
                    color: AppColor.whiteColor,
                    fontSize: FontConstant.extraBigFont23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void checkUserLoggedIn() async {
    final bool isUserLogin = getBool(PrefConstants.isUserLoggedIn);
    await Future.delayed(const Duration(seconds: 3));
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    _animationController.dispose();
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

  void _animationConfiguration() async {
    // Initialize the animation controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Define the fade-in animation
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Start the animation
    await _animationController.forward();
  }
}
