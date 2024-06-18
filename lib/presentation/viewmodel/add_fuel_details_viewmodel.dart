import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/domain/domain_module.dart';
import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/usecase/add_new_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/delete_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/get_fuel_entry_usecase.dart';
import 'package:petrolin/domain/usecase/update_fuel_entry_usecase.dart';
import 'package:petrolin/presentation/viewmodel/fuel_entry_list_viewmodel.dart';
import 'package:petrolin/presentation/viewmodel/home_viewmodel.dart';

final addFuelDetailsViewModelNotifier = Provider<AddFuelDetailViewModel>((ref) {
  return AddFuelDetailViewModel(ref);
});

class AddFuelDetailViewModel {
  final Ref _ref;

  AddFuelDetailViewModel(this._ref);

  Future<int> addNewFuelEntry(
    double fuelCost,
    DateTime currentTime,
  ) async {
    final AddNewFuelEntryUseCase prov =
        _ref.read(addNewFuelEntryUseCaseProvider);
    final result = await prov.addFuelEntry(fuelCost, 'petrol', currentTime);
    _ref.read(homeViewModelNotifierProvider.notifier).updateValue();
    return result;
  }

  Future<void> updateFuelEntry(
    int id,
    double fuelCost,
    DateTime currentTime,
  ) async {
    final UpdateFuelEntryUseCase prov =
        _ref.read(getUpdateFuelEntryUseCaseProvider);
    final FuelEntry entry = FuelEntry(
        id: id, fuelCost: fuelCost, fuelType: 'Petrol', entryTime: currentTime);
    await prov.execute(entry);
    _ref.read(fuelEntryListViewmodelNotifier.notifier).updateValue();
    _ref.read(homeViewModelNotifierProvider.notifier).updateValue();
  }

  Future<void> deleteEntry(int id) async {
    final DeleteFuelEntryUseCase prov =
        _ref.read(deleteFuelEntryUseCaseProvider);
    final result = prov.execute(id);
    _ref.read(fuelEntryListViewmodelNotifier.notifier).updateValue();
    _ref.read(homeViewModelNotifierProvider.notifier).updateValue();
    return result;
  }

  Future<FuelEntry?> getFuelEntryById(int id) async {
    final GetFuelEntryUseCase prov = _ref.read(getFuelEntryUseCaseProvider);
    final result = await prov.execute(id);
    return result;
  }
}
