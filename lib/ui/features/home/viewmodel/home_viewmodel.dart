import 'dart:async';

import 'package:petrolin/domain/domain_module.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<double> build() async {
    return await _fetchTotalCost();
  }

  Future<double> _fetchTotalCost() async {
    try {
      // Set the state to loading
      state = const AsyncValue.loading();

      // Get the use case
      final getTotalCostUseCase = ref.read(getTotalCostUseCaseProvider);

      // Execute the use case to get the value
      final result = await getTotalCostUseCase.execute();

      // Set the state to data
      state = AsyncValue.data(result);

      return result;
    } catch (e, stack) {
      // Handle any errors
      state = AsyncValue.error(e, stack);
      return Future.error(e, stack);
    }
  }

  Future<void> updateValue() async {
    await _fetchTotalCost();
  }
}
