import 'dart:ffi';

import 'package:petrolin/data/datasource/weather_datasource.dart';
import 'package:petrolin/domain/model/weather.dart';
import 'package:petrolin/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource _weatherDataSource;

  WeatherRepositoryImpl(this._weatherDataSource);

  @override
  Future<Weather> fetchWeatherData(double latitude, double longitude) async {
    return await _weatherDataSource.fetchWeatherData(latitude, longitude);
  }
}
