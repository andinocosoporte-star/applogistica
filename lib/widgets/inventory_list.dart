import 'package:flutter/material.dart';
import '../models/inventory_item.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Performance: Use ListView.builder for efficient scrolling
      itemCount: 100, // Replace with actual data length
      itemBuilder: (context, index) {
        // Performance: Use const constructor when possible
        return const InventoryListItem();
      },
      // Performance: Add cache extent for better scrolling performance
      cacheExtent: 100.0,
      // Performance: Use physics for smooth scrolling
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }
}

class InventoryListItem extends StatelessWidget {
  const InventoryListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        // Performance: Use const constructors for static widgets
        leading: const CircleAvatar(
          child: Icon(Icons.inventory),
        ),
        title: const Text('Inventory Item'),
        subtitle: const Text('Description of the item'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Handle item tap
        },
      ),
    );
  }
}