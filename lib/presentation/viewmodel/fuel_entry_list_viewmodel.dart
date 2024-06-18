import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/domain/domain_module.dart';
import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/usecase/get_fuel_entry_list_usecase.dart';

final fuelEntryListViewmodelNotifier =
    AsyncNotifierProvider.autoDispose<FuelEntryListViewmodel, List<FuelEntry>>(
        FuelEntryListViewmodel.new);

class FuelEntryListViewmodel extends AutoDisposeAsyncNotifier<List<FuelEntry>> {
  @override
  FutureOr<List<FuelEntry>> build() async {
    return await _getFuelEntryList();
  }

  Future<List<FuelEntry>> _getFuelEntryList() async {
    try {
      state = const AsyncValue.loading();

      final GetFuelEntryListUseCase getFuelEntryListUseCase =
          ref.read(getFuelEntryListUseCaseProvider);

      final result = await getFuelEntryListUseCase.execute();

      state = AsyncValue.data(result);
      return result;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return Future.error(e, stack);
    }
  }

  Future<void> updateValue() async {
    await _getFuelEntryList();
  }
}
