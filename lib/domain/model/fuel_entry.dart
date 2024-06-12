class FuelEntry {
  static String columnId = '_id';
  static String columnFuelCost = 'fuel_cost';
  static String columnFuelType = 'fuel_type';
  static String columnEntryTime = 'entry_time';

  final int? id;
  final double fuelCost;
  final String fuelType;
  final DateTime entryTime;

  const FuelEntry(
      {this.id,
      required this.fuelCost,
      required this.fuelType,
      required this.entryTime});
}
