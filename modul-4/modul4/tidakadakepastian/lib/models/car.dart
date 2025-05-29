class Car {
  final String id;
  final String brand;
  final String model;
  final String status;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.status,
  });

  factory Car.fromMap(Map<String, dynamic> data, String id) {
    return Car(
      id: id,
      brand: data['brand'] ?? '',
      model: data['model'] ?? '',
      status: data['status'] ?? 'Available',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'model': model,
      'status': status,
    };
  }
}
