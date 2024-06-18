import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class UpdateFuelEntryUseCase {
  Future<void> execute(FuelEntry entry);
}

class UpdateFuelEntryUseCaseImpl extends UpdateFuelEntryUseCase {
  final FuelRepository _fuelRepository;

  UpdateFuelEntryUseCaseImpl(this._fuelRepository);

  @override
  Future<void> execute(FuelEntry entry) async {
    _fuelRepository.updateFuelEntry(entry);
  }
}
