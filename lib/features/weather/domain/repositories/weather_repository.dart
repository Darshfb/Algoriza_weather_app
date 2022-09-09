import 'package:dartz/dartz.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';

abstract class WeatherRepository {
  Future<Either<Failure, CurrentWeatherModel>> getCurrentWeather(
      {required String cityName});
}
