import 'package:petrolin/domain/model/fuel_entry.dart';

abstract class FuelRepository {
  Future<List<FuelEntry>> getAllFuelEntries();
}
