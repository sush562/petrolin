import 'package:petrolin/domain/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeatherData(double latitude, double longitude);
}
