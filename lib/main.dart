import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spymatch/src/features/auth/presentation/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPYMATCH',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF13EC92),
        scaffoldBackgroundColor: const Color(0xFF10221A),
        textTheme: GoogleFonts.lexendTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: const Color(0xFF13EC92),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
