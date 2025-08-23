import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';

void main() {
  // Performance optimization: Ensure Flutter is initialized properly
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        // Add your providers here
      ],
      child: const CatechInventoryApp(),
    ),
  );
}