import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class DeleteFuelEntryUseCase {
  Future<void> execute(int id);
}

class DeleteFuelEntryUseCaseImpl extends DeleteFuelEntryUseCase {
  final FuelRepository _fuelRepository;
  DeleteFuelEntryUseCaseImpl(this._fuelRepository);

  @override
  Future<void> execute(int id) => _fuelRepository.deleteFuelEntry(id);
}
