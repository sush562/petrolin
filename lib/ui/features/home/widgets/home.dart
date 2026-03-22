import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/ui/features/add_update_fuel/widgets/add_fuel_details.dart';
import 'package:petrolin/ui/features/fuel_entry_list/widgets/fuel_entry_list.dart';
import 'package:petrolin/ui/features/info/widgets/info.dart';
import 'package:petrolin/ui/features/home/widgets/weather_widget.dart';
import 'package:petrolin/ui/features/home/viewmodel/home_viewmodel.dart';
import 'package:petrolin/ui/core/ui/text.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewmodel = ref.watch(homeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: textAppBar("PetrolIn", context),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textLarge('Hello User,', context),
              const SizedBox(height: 16),
              viewmodel.when(
                data: (cost) => textSmall(
                  "Your total expenditure of Fuel till date is Rs $cost",
                  context,
                ),
                error: (e, __) => textSmall('Error', context),
                loading: () =>
                    textSmall('Fetching total fuel cost...', context),
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
                  child: textSmall('View Fuel Fill List', context),
                ),
              ),
              const SizedBox(height: 16),
              const WeatherWidget(),
            ],
          ),
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
