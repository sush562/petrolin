import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/domain/domain_module.dart';

final homeViewModelNotifierProvider =
    AsyncNotifierProvider<HomeViewModel, double>(HomeViewModel.new,
        isAutoDispose: true);

class HomeViewModel extends AsyncNotifier<double> {
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
