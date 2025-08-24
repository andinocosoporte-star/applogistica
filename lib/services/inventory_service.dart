import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/inventory_item.dart';

class InventoryService {
  static const String _baseUrl = 'https://api.example.com'; // Replace with actual API
  
  // Performance: Cache for frequently accessed data
  static final Map<String, InventoryItem> _cache = {};
  static DateTime? _lastCacheUpdate;
  static const Duration _cacheValidity = Duration(minutes: 5);

  // Performance: Singleton pattern to avoid multiple instances
  static final InventoryService _instance = InventoryService._internal();
  factory InventoryService() => _instance;
  InventoryService._internal();

  // Performance: Efficient data fetching with caching
  Future<List<InventoryItem>> getInventoryItems() async {
    // Check cache validity
    if (_cache.isNotEmpty && _lastCacheUpdate != null) {
      final timeSinceUpdate = DateTime.now().difference(_lastCacheUpdate!);
      if (timeSinceUpdate < _cacheValidity) {
        return _cache.values.toList();
      }
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/inventory'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10)); // Performance: Add timeout

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final items = jsonData.map((json) => InventoryItem.fromJson(json)).toList();
        
        // Update cache
        _cache.clear();
        for (final item in items) {
          _cache[item.id] = item;
        }
        _lastCacheUpdate = DateTime.now();
        
        return items;
      } else {
        throw Exception('Failed to load inventory: ${response.statusCode}');
      }
    } catch (e) {
      // Performance: Return cached data if available, even if stale
      if (_cache.isNotEmpty) {
        return _cache.values.toList();
      }
      rethrow;
    }
  }

  // Performance: Efficient item search
  Future<List<InventoryItem>> searchItems(String query) async {
    final allItems = await getInventoryItems();
    if (query.isEmpty) return allItems;
    
    // Performance: Use efficient string search
    return allItems.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase()) ||
             item.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  // Performance: Efficient item update
  Future<bool> updateItem(InventoryItem item) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/inventory/${item.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(item.toJson()),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        // Update cache
        _cache[item.id] = item;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Performance: Clear cache when needed
  void clearCache() {
    _cache.clear();
    _lastCacheUpdate = null;
  }
}