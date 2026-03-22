import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/data/data_module.dart';
import 'package:petrolin/data/repository/impl/weather_repository_impl.dart';
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

final getFuelEntryListUseCaseProvider = Provider<GetFuelEntryListUseCase>(
    (ref) => GetFuelEntryListUseCaseImpl(ref.watch(fuelRepositoryProvider)));
final getFuelEntryUseCaseProvider = Provider<GetFuelEntryUseCase>(
    (ref) => GetFuelEntryUseCaseImpl(ref.watch(fuelRepositoryProvider)));
final addNewFuelEntryUseCaseProvider = Provider<AddNewFuelEntryUseCase>(
    (ref) => AddNewFuelEntryUseCaseImpl(ref.watch(fuelRepositoryProvider)));
final deleteFuelEntryUseCaseProvider = Provider<DeleteFuelEntryUseCase>(
    (ref) => DeleteFuelEntryUseCaseImpl(ref.watch(fuelRepositoryProvider)));
final getTotalCostUseCaseProvider = Provider<GetTotalCostUseCase>(
    (ref) => GetTotalCostUseCaseImpl(ref.watch(fuelRepositoryProvider)));
final getUpdateFuelEntryUseCaseProvider = Provider<UpdateFuelEntryUseCase>(
    (ref) => UpdateFuelEntryUseCaseImpl(ref.watch(fuelRepositoryProvider)));
final getFuelPricePerLiterUseCaseProvider =
    Provider<GetFuelPricePerLiterUseCase>((ref) =>
        GetFuelPricePerLiterUseCaseImpl(ref.watch(fuelRepositoryProvider)));
final getAddUpdateFuelPerLiterUsecaseProvider =
    Provider<AddUpdateFuelPerLiterUsecase>((ref) =>
        AddUpdateFuelPerLiterUsecaseImpl(ref.watch(fuelRepositoryProvider)));

@riverpod
FetchWeatherDataUsecase fetchWeatherDataUsecase(Ref ref) {
  final usecase = ref.watch(weatherRepositoryProvider);
  return FetchWeatherDataUsecaseImpl(usecase);
}
