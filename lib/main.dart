import 'package:flutter/material.dart';
import 'package:moment_dart_demo/home.dart';

void main() {
  runApp(const DemoApp());
}

class DemoApp extends StatefulWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Cascadia Code',
            fontFamilyFallback: [
              'Roboto',
              'Noto Sans Mongolian',
            ],
          ),
          labelMedium: TextStyle(
            fontFamily: 'Cascadia Code',
            fontFamilyFallback: [
              'Roboto',
              'Noto Sans Mongolian',
            ],
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodyText2: TextStyle(
            fontFamilyFallback: [
              'Roboto',
              'Noto Sans Mongolian',
            ],
          ),
          subtitle1: TextStyle(
            fontFamilyFallback: [
              'Roboto',
              'Noto Sans Mongolian',
            ],
          ),
        ),
        chipTheme: ChipThemeData(
          labelStyle: const TextStyle(
            fontFamilyFallback: [
              'Roboto',
              'Noto Sans Mongolian',
            ],
            fontWeight: FontWeight.w500,
          ),
          selectedColor: Colors.deepPurple.shade100,
        ),
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}
