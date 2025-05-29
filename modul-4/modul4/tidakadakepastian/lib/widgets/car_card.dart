import 'package:flutter/material.dart';
import '../models/car.dart';
import '../screens/car_form_screen.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final VoidCallback onDelete;
  final void Function(Car) onUpdate;

  const CarCard({super.key, required this.car, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(car.brand),
        subtitle: Text('Model: ${car.model}\nStatus: ${car.status}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final updatedCar = await Navigator.push<Car>(
                  context,
                  MaterialPageRoute(builder: (_) => CarFormScreen(car: car)),
                );
                if (updatedCar != null) onUpdate(updatedCar);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
