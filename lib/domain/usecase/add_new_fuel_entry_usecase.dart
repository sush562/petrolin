import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class AddNewFuelEntryUseCase {
  Future<int> addFuelEntry(double fuelCost, String fuelType);
}

class AddNewFuelEntryUseCaseImpl extends AddNewFuelEntryUseCase {
  final FuelRepository _fuelRepository;

  AddNewFuelEntryUseCaseImpl(this._fuelRepository);

  @override
  Future<int> addFuelEntry(double fuelCost, String fuelType) async {
    final currentTime = DateTime.now();
    final data = FuelEntry(
        fuelCost: fuelCost, fuelType: fuelType, entryTime: currentTime);

    return await _fuelRepository.insertFuelEntry(data);
  }
}
