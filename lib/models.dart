import 'dart:convert';
import 'dart:math' as math;

/// Performance-optimized data models with efficient serialization
/// Using immutable classes and factory constructors for better performance

class InventoryItem {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final double price;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
    this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Performance optimization: Efficient factory constructor with null safety
  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Performance optimization: Efficient JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'quantity': quantity,
      'price': price,
      if (description != null) 'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Performance optimization: Efficient copyWith method
  InventoryItem copyWith({
    String? id,
    String? name,
    String? category,
    int? quantity,
    double? price,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryItem && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'InventoryItem(id: $id, name: $name, quantity: $quantity)';
}

/// Performance-optimized location model
class Location {
  final double latitude;
  final double longitude;
  final String? address;
  final String? name;

  const Location({
    required this.latitude,
    required this.longitude,
    this.address,
    this.name,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      if (address != null) 'address': address,
      if (name != null) 'name': name,
    };
  }

  /// Performance optimization: Calculate distance efficiently
  double distanceTo(Location other) {
    const double earthRadius = 6371; // km
    final double dLat = _toRadians(other.latitude - latitude);
    final double dLon = _toRadians(other.longitude - longitude);
    
    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(latitude)) * math.cos(_toRadians(other.latitude)) *
        math.sin(dLon / 2) * math.sin(dLon / 2);
    
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) => degrees * (math.pi / 180);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;
}

/// Performance-optimized route point model
class RoutePoint {
  final String id;
  final Location location;
  final String name;
  final int estimatedTimeMinutes;
  final bool isCompleted;
  final DateTime? completedAt;
  final int priority;

  const RoutePoint({
    required this.id,
    required this.location,
    required this.name,
    required this.estimatedTimeMinutes,
    this.isCompleted = false,
    this.completedAt,
    this.priority = 1,
  });

  factory RoutePoint.fromJson(Map<String, dynamic> json) {
    return RoutePoint(
      id: json['id'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      name: json['name'] as String,
      estimatedTimeMinutes: json['estimatedTimeMinutes'] as int,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      priority: json['priority'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location.toJson(),
      'name': name,
      'estimatedTimeMinutes': estimatedTimeMinutes,
      'isCompleted': isCompleted,
      if (completedAt != null) 'completedAt': completedAt!.toIso8601String(),
      'priority': priority,
    };
  }

  RoutePoint copyWith({
    String? id,
    Location? location,
    String? name,
    int? estimatedTimeMinutes,
    bool? isCompleted,
    DateTime? completedAt,
    int? priority,
  }) {
    return RoutePoint(
      id: id ?? this.id,
      location: location ?? this.location,
      name: name ?? this.name,
      estimatedTimeMinutes: estimatedTimeMinutes ?? this.estimatedTimeMinutes,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      priority: priority ?? this.priority,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutePoint && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Performance-optimized route model
class OptimizedRoute {
  final String id;
  final List<RoutePoint> points;
  final double totalDistanceKm;
  final int totalEstimatedMinutes;
  final DateTime createdAt;
  final String? name;
  final RouteStatus status;

  const OptimizedRoute({
    required this.id,
    required this.points,
    required this.totalDistanceKm,
    required this.totalEstimatedMinutes,
    required this.createdAt,
    this.name,
    this.status = RouteStatus.pending,
  });

  factory OptimizedRoute.fromJson(Map<String, dynamic> json) {
    return OptimizedRoute(
      id: json['id'] as String,
      points: (json['points'] as List<dynamic>)
          .map((point) => RoutePoint.fromJson(point as Map<String, dynamic>))
          .toList(),
      totalDistanceKm: (json['totalDistanceKm'] as num).toDouble(),
      totalEstimatedMinutes: json['totalEstimatedMinutes'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String?,
      status: RouteStatus.values.firstWhere(
        (status) => status.toString().split('.').last == json['status'],
        orElse: () => RouteStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'points': points.map((point) => point.toJson()).toList(),
      'totalDistanceKm': totalDistanceKm,
      'totalEstimatedMinutes': totalEstimatedMinutes,
      'createdAt': createdAt.toIso8601String(),
      if (name != null) 'name': name,
      'status': status.toString().split('.').last,
    };
  }

  /// Performance optimization: Calculate completion percentage efficiently
  double get completionPercentage {
    if (points.isEmpty) return 0.0;
    final completedCount = points.where((point) => point.isCompleted).length;
    return completedCount / points.length;
  }

  /// Performance optimization: Get remaining points efficiently
  List<RoutePoint> get remainingPoints =>
      points.where((point) => !point.isCompleted).toList();

  OptimizedRoute copyWith({
    String? id,
    List<RoutePoint>? points,
    double? totalDistanceKm,
    int? totalEstimatedMinutes,
    DateTime? createdAt,
    String? name,
    RouteStatus? status,
  }) {
    return OptimizedRoute(
      id: id ?? this.id,
      points: points ?? this.points,
      totalDistanceKm: totalDistanceKm ?? this.totalDistanceKm,
      totalEstimatedMinutes: totalEstimatedMinutes ?? this.totalEstimatedMinutes,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptimizedRoute && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

enum RouteStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

/// Performance optimization: Batch operations for better efficiency
class BatchOperationResult<T> {
  final List<T> successful;
  final List<BatchError> errors;
  final int totalProcessed;

  const BatchOperationResult({
    required this.successful,
    required this.errors,
    required this.totalProcessed,
  });

  bool get hasErrors => errors.isNotEmpty;
  bool get isFullSuccess => errors.isEmpty;
  double get successRate => totalProcessed > 0 ? successful.length / totalProcessed : 0.0;
}

class BatchError {
  final int index;
  final String message;
  final dynamic originalData;

  const BatchError({
    required this.index,
    required this.message,
    this.originalData,
  });
}