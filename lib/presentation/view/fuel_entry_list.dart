import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/presentation/view/add_fuel_details.dart';
import 'package:petrolin/presentation/viewmodel/fuel_entry_list_viewmodel.dart';

class FuelEntryListScreen extends ConsumerWidget {
  const FuelEntryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(fuelEntryListViewmodelNotifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Fuel Entries",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: viewmodel.when(
        data: (fuelEntries) {
          if (fuelEntries.isEmpty) {
            return const Center(
              child: Text(
                'No Entries',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: fuelEntries.length,
            itemBuilder: (context, index) {
              final fuelEntry = fuelEntries[index];
              return Card(
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    '${fuelEntry.fuelType} - Rs ${fuelEntry.fuelCost.toStringAsFixed(2)}',
                  ),
                  subtitle: Text(
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    '${fuelEntry.entryTime.toLocal()}'.split(' ')[0],
                  ),
                  onTap: () {
                    int fuelId = fuelEntry.id!;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddPetrolDetailsScreen(
                          id: fuelId,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
