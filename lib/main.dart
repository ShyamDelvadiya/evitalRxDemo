import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/route/route_path.dart';
import 'package:untitled/route/routes.dart';
import 'package:untitled/screen/splash_screen/view/splash_screen.dart';
import 'package:untitled/utils/preference_utils.dart';
import 'package:untitled/utils/string_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: const MaterialApp(
        title: StringConstant.appName,
        onGenerateRoute: Routes.generateRoute,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // initialRoute: loginScreen,
      ),
    );
  }
}