class Vehicle {
  static String columnId = '_id';
  static String columnVehicleName = 'vehicle_name';
  static String columnVehicleNumber = 'vehicle_number';
  static String columnVehicleNickName = 'vehicle_nick_name';
  static String columnVehicleFuelType = 'vehicle_fuel_type';
  static String columnVehiclePUCEndDate = 'vehicle_puc_end_date';
  static String columnVehicleInsuranceEndDate = 'vehicle_insurance_end_date';
  static String columnVehicleNextMaintenanceDate =
      'vehicle_next_maintenance_date';

  final int? id;
  final String vehicleName;
  final String vehicleNumber;
  final String vehicleNickName;
  final String vehicleFuelType;
  final DateTime? vehiclePUCEndDate;
  final DateTime? vehicleInsuranceEndDate;
  final DateTime? vehicleNextMaintenanceDate;

  const Vehicle({
    this.id,
    required this.vehicleName,
    required this.vehicleFuelType,
    this.vehicleNumber = "",
    this.vehicleNickName = "",
    this.vehiclePUCEndDate,
    this.vehicleInsuranceEndDate,
    this.vehicleNextMaintenanceDate,
  });
}
