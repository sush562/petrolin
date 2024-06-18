import 'package:petrolin/data/datasource/database/fuel_database.dart';
import 'package:petrolin/data/datasource/entity/fuel_entity.dart';
import 'package:petrolin/data/mapper/fuel_entry_mapper.dart';
import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

class FuelRepositoryImpl extends FuelRepository {
  final FuelDatabase database;

  FuelRepositoryImpl(this.database);

  @override
  Future<List<FuelEntry>> getAllFuelEntries() async {
    final FuelEntryListEntity data = await database.getAllFuelEntries();
    return FuelEntryMapper.convertToList(data);
  }

  @override
  Future<void> deleteFuelEntry(int id) async {
    return database.deleteFuelEntry(id);
  }

  @override
  Future<FuelEntry?> getFuelEntry(int id) async {
    final data = await database.getFuelEntry(id);
    if (data == null) {
      return null;
    } else {
      return FuelEntryMapper.transformToModel(data);
    }
  }

  @override
  Future<int> insertFuelEntry(FuelEntry row) async {
    return await database.insertFuelEntry(FuelEntryMapper.transformToMap(row));
  }

  @override
  Future<double> getTotalCost() async {
    return await database.getSumOfFuelCost();
  }

  @override
  Future<int> updateFuelEntry(FuelEntry row) async {
    return await database.updateFuelEntry(
        row.id!, FuelEntryMapper.transformToMap(row));
  }
}
