class FuelEntry {
  static String columnId = '_id';
  static String columnFuelCost = 'fuel_cost';
  static String columnFuelType = 'fuel_type';
  static String columnEntryTime = 'entry_time';
  static String columnFuelPerLiterCost = 'fuel_per_liter_cost';
  static String columnNotes = 'fuel_notes';

  final int? id;
  final double fuelCost;
  final String fuelType;
  final DateTime entryTime;
  final double fuelPerLiterCost;
  final String notes;

  const FuelEntry(
      {this.id,
      required this.fuelCost,
      required this.fuelType,
      required this.entryTime,
      required this.fuelPerLiterCost,
      this.notes = ""});
}
