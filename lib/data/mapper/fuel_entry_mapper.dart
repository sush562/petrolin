import 'package:petrolin/data/datasource/entity/fuel_entity.dart';
import 'package:petrolin/domain/model/fuel_entry.dart';

class FuelEntryMapper {
  static FuelEntry transformToModel(final FuelEntryEntity data) {
    return FuelEntry(
        id: data[FuelEntry.columnId],
        fuelCost: data[FuelEntry.columnFuelCost],
        fuelType: data[FuelEntry.columnFuelType],
        entryTime: DateTime.parse(data[FuelEntry.columnEntryTime]),
        fuelPerLiterCost: data[FuelEntry.columnFuelPerLiterCost],
        notes: data[FuelEntry.columnNotes] ?? "");
  }

  static FuelEntryEntity transformToMap(final FuelEntry data) {
    return {
      FuelEntry.columnId: data.id,
      FuelEntry.columnFuelCost: data.fuelCost,
      FuelEntry.columnFuelType: data.fuelType,
      FuelEntry.columnEntryTime: data.entryTime.toIso8601String(),
      FuelEntry.columnFuelPerLiterCost: data.fuelPerLiterCost,
      FuelEntry.columnNotes: data.notes
    };
  }

  static List<FuelEntry> convertToList(final FuelEntryListEntity data) {
    return data
        .map((entity) => FuelEntryMapper.transformToModel(entity))
        .toList();
  }
}
