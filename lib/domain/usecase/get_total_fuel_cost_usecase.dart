import 'package:petrolin/domain/repository/fuel_repository.dart';

abstract class GetTotalCostUseCase {
  Future<double> execute();
}

class GetTotalCostUseCaseImpl extends GetTotalCostUseCase {
  final FuelRepository _fuelRepository;

  GetTotalCostUseCaseImpl(this._fuelRepository);

  @override
  Future<double> execute() async {
    return await _fuelRepository.getTotalCost();
  }
}
