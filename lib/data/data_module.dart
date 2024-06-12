import 'package:petrolin/data/datasource/database/fuel_database.dart';
import 'package:petrolin/data/datasource/database/fuel_database_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petrolin/data/repositoryimpl/fuel_repository_impl.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

final fuelDatabaseProvider = Provider<FuelDatabase>((_) => FuelDatabaseImpl());
final fuelRepositoryProvider = Provider<FuelRepository>(
    (ref) => FuelRepositoryImpl(ref.watch(fuelDatabaseProvider)));
