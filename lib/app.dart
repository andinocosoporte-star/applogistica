import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class CatechInventoryApp extends StatelessWidget {
  const CatechInventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catech Inventory Routes',
      debugShowCheckedModeBanner: false, // Performance: Remove debug banner
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        // Performance: Optimize theme for better rendering
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}