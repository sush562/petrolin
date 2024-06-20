import 'package:petrolin/domain/model/fuel_price_per_liter.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class AddUpdateFuelPerLiterUsecase {
  Future<void> execute(FuelPricePerLiter entry);
}

class AddUpdateFuelPerLiterUsecaseImpl extends AddUpdateFuelPerLiterUsecase {
  final FuelRepository _fuelRepository;

  AddUpdateFuelPerLiterUsecaseImpl(this._fuelRepository);

  @override
  Future<void> execute(FuelPricePerLiter entry) async {
    _fuelRepository.addUpdateFuelPricePerLiter(entry);
  }
}
