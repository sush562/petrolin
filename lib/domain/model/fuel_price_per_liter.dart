class FuelPricePerLiter {
  static String columnId = '_id';
  static String columnFuelPerLiterCost = 'fuel_per_liter_cost';
  static String columnFuelType = 'fuel_type';
  static String columnEntryTime = 'entry_time';

  final int? id;
  final double fuelPerLiterCost;
  final String fuelType;
  final DateTime entryTime;

  const FuelPricePerLiter({
    this.id,
    required this.fuelPerLiterCost,
    required this.fuelType,
    required this.entryTime,
  });
}
