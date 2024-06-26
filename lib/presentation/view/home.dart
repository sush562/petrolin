import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/presentation/view/add_fuel_details.dart';
import 'package:petrolin/presentation/view/fuel_entry_list.dart';
import 'package:petrolin/presentation/view/info.dart';
import 'package:petrolin/presentation/viewmodel/home_viewmodel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(homeViewModelNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Fuel Entry",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InfoScreen(),
                  ),
                );
              },
              color: Colors.white,
              icon: const Icon(Icons.info))
        ],
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
            const SizedBox(height: 16),
            viewmodel.when(
              data: (cost) => Text(
                "Your total expenditure of Fuel till date is Rs $cost",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              error: (e, __) => const Text('Error'),
              loading: () => const Text('Fetching total fuel cost...'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FuelEntryListScreen(),
                    ),
                  );
                },
                child: const Text('View Fuel Fill List'),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPetrolDetailsScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
