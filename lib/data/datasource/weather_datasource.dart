import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;
import 'package:petrolin/domain/model/weather.dart';
import 'package:petrolin/env/env.dart';

const BASE_URL = 'https://api.weatherapi.com/v1';

abstract class WeatherDataSource {
  Future<Weather> fetchWeatherData(double latitude, double longitude);
}

class WeatherDataSourceImpl extends WeatherDataSource {
  @override
  Future<Weather> fetchWeatherData(double latitude, double longitude) async {
    final weatherKey = Env.weatherKey;
    final response = await http.get(Uri.parse(
        '$BASE_URL/current.json?key=$weatherKey&q=$latitude,$longitude'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final Weather data = await Isolate.run<Weather>(() {
        return Weather.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      });
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
