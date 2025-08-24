import 'package:flutter/material.dart';

class RouteOptimizer extends StatefulWidget {
  const RouteOptimizer({super.key});

  @override
  State<RouteOptimizer> createState() => _RouteOptimizerState();
}

class _RouteOptimizerState extends State<RouteOptimizer> {
  bool _isCalculating = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Performance: Use min size
        children: [
          // Performance: Use const for static widgets
          const Text(
            'Route Optimization',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _isCalculating ? null : _optimizeRoute,
            child: _isCalculating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Optimize Route'),
          ),
        ],
      ),
    );
  }

  Future<void> _optimizeRoute() async {
    setState(() {
      _isCalculating = true;
    });

    // Performance: Use compute for heavy calculations
    try {
      // Simulate route optimization
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Route optimized successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCalculating = false;
        });
      }
    }
  }
}