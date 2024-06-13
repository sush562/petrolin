import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/domain/domain_module.dart';
import 'package:petrolin/domain/usecase/add_new_fuel_entry_usecase.dart';
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
}
