import 'package:petrolin/data/datasource/entity/fuel_entity.dart';

abstract class FuelDatabase {
  Future<FuelEntryListEntity> getAllFuelEntries();
}
