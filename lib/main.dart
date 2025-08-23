import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app_provider.dart';
import 'route_provider.dart';
import 'screens/inventory_list_screen.dart';
import 'screens/route_optimization_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Performance optimization: Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Performance optimization: Hide system UI overlays for better performance
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Performance optimization: Use ChangeNotifierProvider.value when possible
        ChangeNotifierProvider(
          create: (_) => AppProvider(),
          lazy: false, // Pre-load for better UX
        ),
        ChangeNotifierProvider(
          create: (_) => RouteProvider(),
          lazy: true, // Lazy load route provider
        ),
      ],
      child: MaterialApp(
        title: 'CATech Inventario + Rutas',
        debugShowCheckedModeBanner: false,
        
        // Performance optimization: Define theme once
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          
          // Performance optimization: Pre-define commonly used text styles
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            bodyLarge: TextStyle(fontSize: 16),
            bodyMedium: TextStyle(fontSize: 14),
          ),
          
          // Performance optimization: Define app bar theme once
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 2,
            centerTitle: true,
          ),
        ),
        
        // Performance optimization: Use named routes for better memory management
        initialRoute: '/',
        routes: {
          '/': (context) => const MainNavigationScreen(),
          '/inventory': (context) => const InventoryListScreen(),
          '/routes': (context) => const RouteOptimizationScreen(),
        },
        
        // Performance optimization: Handle route generation efficiently
        onGenerateRoute: (settings) {
          // Handle dynamic routes if needed
          return null;
        },
      ),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  
  // Performance optimization: Pre-create screen instances to avoid rebuilding
  late final List<Widget> _screens;
  
  @override
  void initState() {
    super.initState();
    _screens = [
      const InventoryListScreen(),
      const RouteOptimizationScreen(),
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route),
            label: 'Rutas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}