import 'package:petrolin/data/datasource/database/fuel_database.dart';
import 'package:petrolin/data/datasource/database/fuel_database_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/data/datasource/weather_datasource.dart';
import 'package:petrolin/data/repository/impl/fuel_repository_impl.dart';
import 'package:petrolin/data/repository/impl/weather_repository_impl.dart';
import 'package:petrolin/data/repository/fuel_repository.dart';
import 'package:petrolin/data/repository/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_module.g.dart';

final fuelDatabaseProvider = Provider<FuelDatabase>(
  (_) => FuelDatabaseImpl(),
);
final fuelRepositoryProvider = Provider<FuelRepository>(
  (ref) => FuelRepositoryImpl(
    ref.watch(fuelDatabaseProvider),
  ),
);

@riverpod
WeatherDataSource weatherDataSource(Ref ref) {
  return WeatherDataSourceImpl();
}

@riverpod
WeatherRepository weatherRepository(Ref ref) {
  final dataSource = ref.watch(weatherDataSourceProvider);
  return WeatherRepositoryImpl(dataSource);
}
