import 'package:flutter/material.dart';
import 'package:gps_maps/Home/home_screen.dart';

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
      routes:
      {
        HomeScreen.routeName: (_)=> const HomeScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}


