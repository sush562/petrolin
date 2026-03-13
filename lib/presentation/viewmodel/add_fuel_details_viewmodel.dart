import 'package:petrolin/data/entity/fuel_types.dart';
import 'package:petrolin/domain/domain_module.dart';
import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/model/fuel_price_per_liter.dart';
import 'package:petrolin/domain/usecase/add_new_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/delete_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/get_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/get_fuel_price_per_liter_usecase.dart';
import 'package:petrolin/domain/usecase/update_fuel_entry_usecase.dart';
import 'package:petrolin/presentation/viewmodel/fuel_entry_list_viewmodel.dart';
import 'package:petrolin/presentation/viewmodel/home_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_fuel_details_viewmodel.g.dart';

@riverpod
class AddFuelDetailViewModel extends _$AddFuelDetailViewModel {
  @override
  void build() {
    return;
  }

  FuelPricePerLiter? petrolPerLiterPrice = null;
  FuelPricePerLiter? dieselPerLiterPrice = null;

  Future<int> addNewFuelEntry(double fuelCost, DateTime currentTime,
      String fuelType, double fuelPerLiterCost, String notes) async {
    final AddNewFuelEntryUseCase prov =
        ref.read(addNewFuelEntryUseCaseProvider);
    if (fuelType == petrol) {
      if (petrolPerLiterPrice == null) {
        petrolPerLiterPrice = FuelPricePerLiter(
            fuelPerLiterCost: fuelPerLiterCost,
            fuelType: petrol,
            entryTime: DateTime.now());
        await ref
            .read(getAddUpdateFuelPerLiterUsecaseProvider)
            .execute(petrolPerLiterPrice!);
      } else {
        double cost = petrolPerLiterPrice!.fuelPerLiterCost;
        if (cost != fuelPerLiterCost) {
          final int id = petrolPerLiterPrice!.id!;
          petrolPerLiterPrice = FuelPricePerLiter(
              id: id,
              fuelPerLiterCost: fuelPerLiterCost,
              fuelType: petrol,
              entryTime: DateTime.now());
          await ref
              .read(getAddUpdateFuelPerLiterUsecaseProvider)
              .execute(petrolPerLiterPrice!);
        }
      }
    } else {
      if (dieselPerLiterPrice == null) {
        dieselPerLiterPrice = FuelPricePerLiter(
            fuelPerLiterCost: fuelPerLiterCost,
            fuelType: diesel,
            entryTime: DateTime.now());
        await ref
            .read(getAddUpdateFuelPerLiterUsecaseProvider)
            .execute(dieselPerLiterPrice!);
      } else {
        double cost = dieselPerLiterPrice!.fuelPerLiterCost;
        if (cost != fuelPerLiterCost) {
          final int id = dieselPerLiterPrice!.id!;
          dieselPerLiterPrice = FuelPricePerLiter(
              id: id,
              fuelPerLiterCost: fuelPerLiterCost,
              fuelType: diesel,
              entryTime: DateTime.now());
          await ref
              .read(getAddUpdateFuelPerLiterUsecaseProvider)
              .execute(dieselPerLiterPrice!);
        }
      }
    }
    final FuelEntry entry = _getAddFuelEntryData(
        fuelCost, currentTime, fuelType, fuelPerLiterCost, notes);
    final result = await prov.execute(entry);
    ref.read(homeViewModelNotifierProvider.notifier).updateValue();
    return result;
  }

  double getFuelPrice(String fuelType) {
    double price = 0.0;
    if (fuelType == petrol && petrolPerLiterPrice != null) {
      price = petrolPerLiterPrice!.fuelPerLiterCost;
    } else if (fuelType == diesel && dieselPerLiterPrice != null) {
      price = dieselPerLiterPrice!.fuelPerLiterCost;
    }
    return price;
  }

  Future<bool> updateFuelEntry(int? id, double fuelCost, DateTime currentTime,
      String fuelType, double fuelPerLiterCost, String notes) async {
    final UpdateFuelEntryUseCase prov =
        ref.read(getUpdateFuelEntryUseCaseProvider);
    final FuelEntry entry = _getFuelEntryData(
        id, fuelCost, currentTime, fuelType, fuelPerLiterCost, notes);
    await prov.execute(entry);
    ref.read(fuelEntryListViewmodelNotifier.notifier).updateValue();
    ref.read(homeViewModelNotifierProvider.notifier).updateValue();
    return true;
  }

  FuelEntry _getFuelEntryData(int? id, double fuelCost, DateTime currentTime,
      String fuelType, double fuelPerLiterCost, String notes) {
    return FuelEntry(
        id: id,
        fuelCost: fuelCost,
        fuelType: fuelType,
        entryTime: currentTime,
        fuelPerLiterCost: fuelPerLiterCost,
        notes: notes);
  }

  FuelEntry _getAddFuelEntryData(double fuelCost, DateTime currentTime,
      String fuelType, double fuelPerLiterCost, String notes) {
    return FuelEntry(
        fuelCost: fuelCost,
        fuelType: fuelType,
        entryTime: currentTime,
        fuelPerLiterCost: fuelPerLiterCost,
        notes: notes);
  }

  Future<void> deleteEntry(int id) async {
    final DeleteFuelEntryUseCase prov =
        ref.read(deleteFuelEntryUseCaseProvider);
    final result = prov.execute(id);
    ref.read(fuelEntryListViewmodelNotifier.notifier).updateValue();
    ref.read(homeViewModelNotifierProvider.notifier).updateValue();
    return result;
  }

  Future<FuelEntry?> getFuelEntryById(int id) async {
    final GetFuelEntryUseCase prov = ref.read(getFuelEntryUseCaseProvider);
    final result = await prov.execute(id);
    return result;
  }

  Future<void> loadDefaultFuelCosts() async {
    final GetFuelPricePerLiterUseCase prov =
        ref.read(getFuelPricePerLiterUseCaseProvider);
    petrolPerLiterPrice = await prov.execute(petrol);
    dieselPerLiterPrice = await prov.execute(diesel);
  }
}
