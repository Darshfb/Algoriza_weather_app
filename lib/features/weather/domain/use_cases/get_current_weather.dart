import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';
import 'package:weather/features/weather/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;

  GetCurrentWeather({required this.repository});

  Future<Either<Failure, CurrentWeatherModel>> call(
      {required String cityName}) async {
    return await repository.getCurrentWeather(cityName: cityName);
  }
}
