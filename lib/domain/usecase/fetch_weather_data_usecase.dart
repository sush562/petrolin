import 'package:petrolin/domain/model/weather.dart';
import 'package:petrolin/domain/repository/weather_repository.dart';

abstract class FetchWeatherDataUsecase {
  Future<Weather> execute(double latitude, double longitude);
}

class FetchWeatherDataUsecaseImpl extends FetchWeatherDataUsecase {
  final WeatherRepository _weatherRepository;

  FetchWeatherDataUsecaseImpl(this._weatherRepository);

  @override
  Future<Weather> execute(double latitude, double longitude) async {
    return await _weatherRepository.fetchWeatherData(latitude, longitude);
  }
}
