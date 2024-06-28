import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class AddNewFuelEntryUseCase {
  Future<int> execute(FuelEntry entry);
}

class AddNewFuelEntryUseCaseImpl extends AddNewFuelEntryUseCase {
  final FuelRepository _fuelRepository;

  AddNewFuelEntryUseCaseImpl(this._fuelRepository);

  @override
  Future<int> execute(FuelEntry entry) async {
    return await _fuelRepository.insertFuelEntry(entry);
  }
}
