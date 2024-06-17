import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class GetFuelEntryUseCase {
  Future<FuelEntry?> execute(int id);
}

class GetFuelEntryUseCaseImpl extends GetFuelEntryUseCase {
  final FuelRepository _fuelRepository;

  GetFuelEntryUseCaseImpl(this._fuelRepository);

  @override
  Future<FuelEntry?> execute(int id) => _fuelRepository.getFuelEntry(id);
}
