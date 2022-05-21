import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:librex/alpha_widgets/alpha_splash_screen.dart';
import 'package:librex/screens/home_screen.dart';
import 'package:librex/style/theme.dart';
import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Upgrader().clearSavedSettings();
    FocusScope.of(context).requestFocus(FocusNode());
    return GetMaterialApp(
      title: 'Libranium',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const AlphaSplashScreen(
          duration: Duration(milliseconds: 5000),
          appname: "Libranium",
          logo: "assets/icons/logo.png",
          child: HomeScreen()),
    );
  }
}
