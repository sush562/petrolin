import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/domain/model/weather.dart';
import 'package:petrolin/domain/utility/location_utility.dart';
import 'package:petrolin/presentation/viewmodel/weather_viewmodel.dart';

class WeatherWidget extends ConsumerStatefulWidget {
  const WeatherWidget({super.key});

  @override
  ConsumerState<WeatherWidget> createState() {
    return _WeatherWidgetState();
  }
}

class _WeatherWidgetState extends ConsumerState<WeatherWidget> {
  late Future<Weather> _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = ref.read(weatherViewModelNotifierProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                children: [
                  SizedBox(height: 8),
                  CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(
                    'Fetching Weather Data',
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ); // Show a loading spinner
          } else if (snapshot.hasError) {
            if (snapshot.error is LocationServiceDisabledException) {
              return const Text(
                  'Unable to display current weather data. Please enable GPS from device settings.');
            }
            if (snapshot.error is PermissionDeniedException) {
              return const Text(
                  'Unable to display current weather data. Please allow location permissions for app from device settings.');
            } else {
              return const Text('Unable to display current weather data.');
            }
          } else if (snapshot.hasData) {
            return Center(
              child: _WeatherDisplayWidget(
                data: snapshot.data!,
              ),
            );
          } else {
            return const Text('Unable to display current weather data.');
          }
        });
  }
}

class _WeatherDisplayWidget extends StatelessWidget {
  const _WeatherDisplayWidget({super.key, required this.data});

  final Weather data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15), // Adjust the radius as needed
        ),
        clipBehavior: Clip.antiAlias,
        elevation: 5.0,
        color: getWeatherCardBGColor(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    getWeatherIcon(),
                    color: getWeatherIconColor(),
                    size: 100,
                  ),
                  const Text(
                    'WeatherApi.com',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    data.current.condition.text,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    '${data.current.tempC}°',
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  Text(
                    data.location.name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getWeatherCardBGColor() {
    if (isDay()) {
      return Colors.blue;
    } else {
      return Colors.black87;
    }
  }

  bool isDay() {
    return data.current.isDay == 1 ? true : false;
  }

  IconData getWeatherIcon() {
    int code = data.current.condition.code;
    switch (code) {
      case 1000:
        return isDay() ? Icons.sunny : Icons.nightlight_round_sharp;
      case 1003:
      case 1006:
      case 1009:
        return Icons.cloud;
      case 1087:
        return Icons.thunderstorm;
      case 1180:
      case 1183:
      case 1186:
      case 1189:
      case 1192:
        return Icons.cloudy_snowing;
      case 1240:
        return isDay() ? Icons.sunny_snowing : Icons.nights_stay_sharp;
      default:
        return isDay() ? Icons.sunny : Icons.nightlight_round_sharp;
    }
  }

  Color getWeatherIconColor() {
    int code = data.current.condition.code;
    print('Weather icon color: $code');
    switch (code) {
      case 1000:
        return isDay() ? Colors.amber : Colors.white;
      case 1003:
      case 1006:
      case 1009:
      case 1087:
        return const Color.fromARGB(255, 142, 141, 141);
      case 1180:
      case 1183:
      case 1186:
      case 1189:
      case 1192:
      default:
        return isDay() ? Colors.amber : Colors.white;
    }
  }
}
