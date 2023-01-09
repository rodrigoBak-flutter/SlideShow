import 'package:flutter/material.dart';

import 'package:app_slideshow_bakapp/src/screens/slideshow_screem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// Este Widget le da inicio a la aplicacion.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SlideShow',
      home: SlideShowScreen(),
    );
  }
}
