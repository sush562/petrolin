import 'package:petrolin/domain/model/fuel_price_per_liter.dart';
import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class GetFuelPricePerLiterUseCase {
  Future<FuelPricePerLiter?> execute(String fuelType);
}

class GetFuelPricePerLiterUseCaseImpl extends GetFuelPricePerLiterUseCase {
  final FuelRepository _fuelRepository;

  GetFuelPricePerLiterUseCaseImpl(this._fuelRepository);

  @override
  Future<FuelPricePerLiter?> execute(String fuelType) async {
    return _fuelRepository.getPricePerLiterFuelType(fuelType);
  }
}
