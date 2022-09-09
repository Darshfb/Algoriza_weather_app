import 'package:dartz/dartz.dart';
import 'package:weather/core/error/exceptions.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/core/shared/Network/info.dart';
import 'package:weather/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';
import 'package:weather/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  // final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    // required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CurrentWeatherModel>> getCurrentWeather(
      {required String cityName}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteWeather =
            await remoteDataSource.getCurrentWeather(cityName: cityName);
        // localDataSource.cachedCurrentWeather(remoteWeather);
        return Right(remoteWeather);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
