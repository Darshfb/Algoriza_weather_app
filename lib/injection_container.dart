import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/shared/Local/cache_helper.dart';
import 'package:weather/core/shared/Network/dio_helper.dart';
import 'package:weather/core/shared/Network/info.dart';
import 'package:weather/features/weather/data/data_sources/weather_local_data_source.dart';
import 'package:weather/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather/features/weather/domain/use_cases/get_current_weather.dart';
import 'package:weather/features/weather/presentation/bloc/weather_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// features Weather

  /// External
  DioHelper();
  await CacheHelper.init();
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => DioHelper);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  /// Cubit
  sl.registerFactory(() => WeatherCubit(currentWeather: sl()));

  /// Use Cases
  sl.registerLazySingleton(() => GetCurrentWeather(repository: sl()));

  /// Repository
  sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  /// Data Sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl());
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl(sharedPreferences: sl()));

  /// Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
}
