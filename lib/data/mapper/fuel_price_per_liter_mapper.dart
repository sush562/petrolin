import 'package:petrolin/data/datasource/entity/fuel_entity.dart';
import 'package:petrolin/domain/model/fuel_price_per_liter.dart';

class FuelPricePerLiterMapper {
  static FuelPricePerLiter transformToModel(final FuelEntryEntity data) {
    return FuelPricePerLiter(
      id: data[FuelPricePerLiter.columnId],
      fuelType: data[FuelPricePerLiter.columnFuelType],
      entryTime: DateTime.parse(data[FuelPricePerLiter.columnEntryTime]),
      fuelPerLiterCost: data[FuelPricePerLiter.columnFuelPerLiterCost],
    );
  }

  static FuelEntryEntity transformToMap(final FuelPricePerLiter data) {
    return {
      FuelPricePerLiter.columnId: data.id,
      FuelPricePerLiter.columnFuelType: data.fuelType,
      FuelPricePerLiter.columnEntryTime: data.entryTime.toIso8601String(),
      FuelPricePerLiter.columnFuelPerLiterCost: data.fuelPerLiterCost,
    };
  }
}
