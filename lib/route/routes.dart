import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/route/route_path.dart';
import 'package:untitled/screen/home_screen/bloc/home_bloc.dart';
import 'package:untitled/screen/home_screen/view/home_screen.dart';
import 'package:untitled/screen/login_screen/bloc/login_bloc.dart';
import 'package:untitled/screen/login_screen/view/login_screen.dart';
import 'package:untitled/screen/splash_screen/view/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Map<String, dynamic>? args = settings.arguments as Map<String, dynamic>?;
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider<LoginBloc>(
                create: (context) => LoginBloc(),
                child: const LoginScreen(),
              ),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider<HomeBloc>(
                create: (context) => HomeBloc(),
                child: const HomeScreen(),
              ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
    }
  }
}
