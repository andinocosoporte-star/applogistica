import 'package:flutter/material.dart';
import '../widgets/inventory_list.dart';
import '../widgets/route_optimizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  // Performance: Keep screen alive to avoid rebuilding
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catech Inventory Routes'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Column(
        children: [
          // Performance: Use Expanded to avoid layout constraints
          Expanded(
            child: InventoryList(),
          ),
          // Performance: Route optimizer at bottom
          RouteOptimizer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add inventory item
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}