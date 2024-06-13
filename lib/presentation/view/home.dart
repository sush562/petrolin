import 'package:flutter/material.dart';
import 'package:petrolin/presentation/view/add_fuel_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            "Home Page",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Hello User",
                style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Your total expenditure of Petrol till date is Rs 5000",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('View Petrol Fill List'),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AddPetrolDetailsScreen()));
                  },
                  child: const Text('Add Petrol'),
                ),
              ),
            ],
          ),
        ));
  }
}
