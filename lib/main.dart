import 'package:flutter/material.dart';
import 'package:news_app/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
            primary: Colors.black,
            secondary: Colors.blue,
            tertiary: Colors.blueGrey),
      ),
      home: const SplashScreen(),
    );
  }
}
