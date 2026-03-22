import 'package:petrolin/data/datasource/database/fuel_database.dart';
import 'package:petrolin/data/datasource/database/fuel_database_impl.dart';
import 'package:petrolin/data/datasource/weather_datasource.dart';
import 'package:petrolin/data/repository/impl/fuel_repository_impl.dart';
import 'package:petrolin/data/repository/impl/weather_repository_impl.dart';
import 'package:petrolin/data/repository/fuel_repository.dart';
import 'package:petrolin/data/repository/weather_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_module.g.dart';

@riverpod
FuelDatabase fuelDatabase(Ref ref) => FuelDatabaseImpl();

@riverpod
FuelRepository fuelRepository(Ref ref) {
  final fuelDataBase = ref.watch(fuelDatabaseProvider);
  return FuelRepositoryImpl(fuelDataBase);
}

@riverpod
WeatherDataSource weatherDataSource(Ref ref) {
  return WeatherDataSourceImpl();
}

@riverpod
WeatherRepository weatherRepository(Ref ref) {
  final dataSource = ref.watch(weatherDataSourceProvider);
  return WeatherRepositoryImpl(dataSource);
}
