import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/presentation/view/add_fuel_details.dart';
import 'package:petrolin/presentation/viewmodel/fuel_entry_list_viewmodel.dart';
import 'package:petrolin/ui/text.dart';

class FuelEntryListScreen extends ConsumerWidget {
  const FuelEntryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(fuelEntryListViewmodelNotifier);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: textAppBar("Fuel Entries", context),
      ),
      body: viewmodel.when(
        data: (fuelEntries) {
          if (fuelEntries.isEmpty) {
            return Center(
              child: textSmall('No Entries', context),
            );
          }
          return ListView.builder(
            itemCount: fuelEntries.length,
            itemBuilder: (context, index) {
              final fuelEntry = fuelEntries[index];
              return Card(
                margin: const EdgeInsets.all(10.0),
                child: ListTile(
                  title: textSmall(
                      '${fuelEntry.fuelType} - Rs ${fuelEntry.fuelCost.toStringAsFixed(2)}',
                      context),
                  subtitle: textSmall(
                      '${fuelEntry.entryTime.toLocal()}'.split(' ')[0],
                      context),
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
