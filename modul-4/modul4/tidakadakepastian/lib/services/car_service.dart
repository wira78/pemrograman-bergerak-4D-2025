import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/car.dart';

class CarService {
  final String baseUrl = 'https://wiraselfi-1aedb-default-rtdb.firebaseio.com';

  Future<List<Car>> fetchCars() async {
    final url = Uri.parse('$baseUrl/cars.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = jsonDecode(response.body);
      if (data == null) return [];
      return data.entries.map((e) => Car.fromMap(e.value, e.key)).toList();
    } else {
      throw Exception('Failed to fetch cars: ${response.statusCode}');
    }
  }

  Future<void> addCar(Car car) async {
    final url = Uri.parse('$baseUrl/cars.json');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(car.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add car: ${response.statusCode}');
    }
  }

  Future<void> updateCar(Car car) async {
    final url = Uri.parse('$baseUrl/cars/${car.id}.json');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(car.toMap()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update car: ${response.statusCode}');
    }
  }

  Future<void> deleteCar(String id) async {
    final url = Uri.parse('$baseUrl/cars/$id.json');
    final response = await http.delete(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete car: ${response.statusCode}');
    }
  }
}
