import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retro_calculator_test/core/constants/app_colors.dart';
import 'package:retro_calculator_test/presentation/screens/screen_calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.vt323(
              fontSize: 48,
          ),
        ),
      ),
      home: ScreenCalculator(),
    );
  }
}
