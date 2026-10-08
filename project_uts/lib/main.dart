import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'PROVIDERS/app_state.dart';
import 'SCREENS/main_navigation.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeWear Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEC1C24),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      ),
      home: const MainNavigation(),
    );
  }
}