class InventoryItem {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final int quantity;
  final DateTime lastUpdated;

  const InventoryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.quantity,
    required this.lastUpdated,
  });

  // Performance: Efficient JSON serialization
  factory InventoryItem.fromJson(Map<String, dynamic> json) {
    return InventoryItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      quantity: json['quantity'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );
  }

  // Performance: Efficient JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'quantity': quantity,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  // Performance: Efficient copy method
  InventoryItem copyWith({
    String? id,
    String? name,
    String? description,
    double? latitude,
    double? longitude,
    int? quantity,
    DateTime? lastUpdated,
  }) {
    return InventoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      quantity: quantity ?? this.quantity,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InventoryItem && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}