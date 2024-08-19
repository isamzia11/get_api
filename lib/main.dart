import 'package:api/example_four.dart';
import 'package:api/example_three.dart';
import 'package:api/example_two.dart';
import 'package:api/home_screen.dart';
import 'package:api/last_example.dart';
import 'package:api/signup.dart';
import 'package:api/upload_image.dart';
import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: UploadImageScreen(),
    );
  }
}
