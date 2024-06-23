class FuelEntry {
  static String columnId = '_id';
  static String columnFuelCost = 'fuel_cost';
  static String columnFuelType = 'fuel_type';
  static String columnEntryTime = 'entry_time';
  static String columnFuelPerLiterCost = 'fuel_per_liter_cost';
  static String columnNotes = 'fuel_notes';
  static String columnVehicleId = 'vehicle_id';
  static String columnVehicleOdometerReading = 'vehicle_odometer_reading';

  final int? id;
  final double fuelCost;
  final String fuelType;
  final DateTime entryTime;
  final double fuelPerLiterCost;
  final String notes;
  final int vehicleId;
  final int vehicleOdometerReading;

  const FuelEntry({
    this.id,
    required this.fuelCost,
    required this.fuelType,
    required this.entryTime,
    required this.fuelPerLiterCost,
    this.notes = "",
    this.vehicleId = 0,
    this.vehicleOdometerReading = 0,
  });
}
