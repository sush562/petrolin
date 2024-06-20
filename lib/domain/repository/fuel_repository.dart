import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/model/fuel_price_per_liter.dart';

abstract class FuelRepository {
  Future<List<FuelEntry>> getAllFuelEntries();
  Future<void> deleteFuelEntry(int id);
  Future<int> insertFuelEntry(FuelEntry row);
  Future<int> updateFuelEntry(FuelEntry row);
  Future<FuelEntry?> getFuelEntry(int id);
  Future<double> getTotalCost();

  Future<FuelPricePerLiter?> getPricePerLiterFuelType(String fuelType);
  Future<int> addUpdateFuelPricePerLiter(FuelPricePerLiter data);
}
