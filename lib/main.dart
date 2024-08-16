import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petrolin/presentation/view/home.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.green,
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
  brightness: Brightness.dark,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetrolIn',
      darkTheme: ThemeData().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kDarkColorScheme.primaryContainer,
          foregroundColor: kDarkColorScheme.onPrimaryContainer,
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
              titleLarge: GoogleFonts.spectral(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: kDarkColorScheme.primary),
              titleSmall: GoogleFonts.spectral(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.secondary,
            foregroundColor: kDarkColorScheme.onSecondary,
          ),
        ),
        scaffoldBackgroundColor: kDarkColorScheme.surface,
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: GoogleFonts.spectral(
                  fontSize: 30, fontWeight: FontWeight.bold),
              titleSmall: GoogleFonts.spectral(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
