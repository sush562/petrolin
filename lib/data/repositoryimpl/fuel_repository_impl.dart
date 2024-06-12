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
}
