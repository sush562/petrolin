import 'package:petrolin/data/data_module.dart';
import 'package:petrolin/domain/usecase/add_new_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/add_update_fuel_per_liter_usecase.dart';
import 'package:petrolin/domain/usecase/delete_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/fetch_weather_data_usecase.dart';
import 'package:petrolin/domain/usecase/get_fuel_entry_list_usecase.dart';
import 'package:petrolin/domain/usecase/get_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/get_fuel_price_per_liter_usecase.dart';
import 'package:petrolin/domain/usecase/get_total_fuel_cost_usecase.dart';
import 'package:petrolin/domain/usecase/update_fuel_entry_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'domain_module.g.dart';

@riverpod
FetchWeatherDataUsecase fetchWeatherDataUsecase(Ref ref) {
  final usecase = ref.watch(weatherRepositoryProvider);
  return FetchWeatherDataUsecaseImpl(usecase);
}

@riverpod
GetTotalCostUseCase getTotalCostUseCase(Ref ref) {
  final fuelRepo = ref.watch(fuelRepositoryProvider);
  return GetTotalCostUseCaseImpl(fuelRepo);
}

@riverpod
AddUpdateFuelPerLiterUsecase addUpdateFuelPerLiterUsecase(Ref ref) {
  final fuelRepo = ref.watch(fuelRepositoryProvider);
  return AddUpdateFuelPerLiterUsecaseImpl(fuelRepo);
}

@riverpod
GetFuelPricePerLiterUseCase getFuelPricePerLiterUseCase(Ref ref) {
  final fuelRepo = ref.watch(fuelRepositoryProvider);
  return GetFuelPricePerLiterUseCaseImpl(fuelRepo);
}

@riverpod
DeleteFuelEntryUseCase deleteFuelEntryUseCase(Ref ref) {
  final fuelRepo = ref.watch(fuelRepositoryProvider);
  return DeleteFuelEntryUseCaseImpl(fuelRepo);
}

@riverpod
GetFuelEntryUseCase getFuelEntryUseCase(Ref ref) {
  final fuelRepo = ref.watch(fuelRepositoryProvider);
  return GetFuelEntryUseCaseImpl(fuelRepo);
}

@riverpod
AddNewFuelEntryUseCase addNewFuelEntryUseCase(Ref ref) {
  final fuelRepo = ref.watch(fuelRepositoryProvider);
  return AddNewFuelEntryUseCaseImpl(fuelRepo);
}

@riverpod
UpdateFuelEntryUseCase updateFuelEntryUseCase(Ref ref) {
  final fuelRepo = ref.watch(fuelRepositoryProvider);
  return UpdateFuelEntryUseCaseImpl(fuelRepo);
}

@riverpod
GetFuelEntryListUseCase getFuelEntryListUseCase(Ref ref) {
  final fuelRepo = ref.watch(fuelRepositoryProvider);
  return GetFuelEntryListUseCaseImpl(fuelRepo);
}
