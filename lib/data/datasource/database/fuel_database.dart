import 'package:petrolin/data/datasource/entity/fuel_entity.dart';

abstract class FuelDatabase {
  Future<FuelEntryListEntity> getAllFuelEntries();
  Future<void> deleteFuelEntry(int id);
  Future<int> insertFuelEntry(FuelEntryEntity row);
  Future<int> updateFuelEntry(int id, FuelEntryEntity row);
  Future<FuelEntryEntity?> getFuelEntry(int id);
  Future<double> getSumOfFuelCost();
}
