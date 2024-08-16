import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:petrolin/domain/domain_module.dart';
import 'package:petrolin/domain/model/weather.dart';
import 'package:petrolin/domain/utility/location_utility.dart';

final weatherViewModelNotifierProvider =
    AsyncNotifierProvider.autoDispose<WeatherViewmodel, Weather>(
        WeatherViewmodel.new);

class WeatherViewmodel extends AutoDisposeAsyncNotifier<Weather> {
  @override
  Future<Weather> build() {
    return _fetchWeatherData();
  }

  Future<Weather> _fetchWeatherData() async {
    try {
      // Set the state to loading
      state = const AsyncValue.loading();

      LocationData? locationData = await LocationUtilty().getLocation();
      if (locationData == null) {
        throw Exception('Unable to fetch error');
      } else {
        // Get the use case
        final fetchWeatherDataUsecase =
            ref.read(getFetchWeatherDataUseCaseProvider);

        // Execute the use case to get the value
        final result = await fetchWeatherDataUsecase.execute(
            locationData.latitude!, locationData.longitude!);

        // Set the state to data
        state = AsyncValue.data(result);

        return result;
      }
    } catch (e, stack) {
      // Handle any errors
      state = AsyncValue.error(e, stack);
      return Future.error(e, stack);
    }
  }
}
