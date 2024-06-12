import 'package:petrolin/domain/model/fuel_entry.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class GetFuelEntryListUseCase {
  Future<List<FuelEntry>> execute();
}

class GetFuelEntryListUseCaseImpl extends GetFuelEntryListUseCase {
  final FuelRepository _fuelRepository;

  GetFuelEntryListUseCaseImpl(this._fuelRepository);

  @override
  Future<List<FuelEntry>> execute() => _fuelRepository.getAllFuelEntries();
}
