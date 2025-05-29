import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/car_service.dart';
import '../widgets/car_card.dart';
import 'car_form_screen.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final CarService carService = CarService();
  List<Car> cars = [];

  @override
  void initState() {
    super.initState();
    loadCars();
  }

  Future<void> loadCars() async {
    final data = await carService.fetchCars();
    setState(() => cars = data);
  }

  void deleteCar(String id) async {
    await carService.deleteCar(id);
    loadCars();
  }

  void updateCar(Car updatedCar) async {
    await carService.updateCar(updatedCar);
    loadCars();
  }

  void addCar(Car car) async {
    await carService.addCar(car);
    loadCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Mobil Yang Tersedia')),
      body: RefreshIndicator(
        onRefresh: loadCars,
        child: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, index) => CarCard(
            car: cars[index],
            onDelete: () => deleteCar(cars[index].id),
            onUpdate: (updated) => updateCar(updated),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCar = await Navigator.push<Car>(
            context,
            MaterialPageRoute(builder: (_) => const CarFormScreen()),
          );
          if (newCar != null) addCar(newCar);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
