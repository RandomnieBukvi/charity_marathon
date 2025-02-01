import 'package:charity_marathon/auth.dart';
import 'package:charity_marathon/payment_test.dart';
import 'package:charity_marathon/widget_tree.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF02a95c), 
        scaffoldBackgroundColor: Color(0xFFfbfaf8), 
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF02a95c),
          foregroundColor: Color(0xFFfbfaf8), 
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: Color(0xFFfbfaf8), fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(color: Color(0xFF1B5E20)),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF02a95c),
            foregroundColor: Color(0xFFfbfaf8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          // Устанавливаем внешний вид для всех текстовых полей
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF02a95c)), // Цвет обводки при фокусе
          ),
          floatingLabelStyle: TextStyle(color: Color(0xFF02a95c)),
        ),
      ),
      home: WidgetTree(),
    );
  }
}
