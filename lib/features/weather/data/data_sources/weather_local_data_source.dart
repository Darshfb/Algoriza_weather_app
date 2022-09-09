import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/error/exceptions.dart';
import 'package:weather/core/shared/Local/cache_helper.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';

abstract class WeatherLocalDataSource {
  Future<CurrentWeatherModel> getCachedCurrentWeather();

  Future<Unit> cachedCurrentWeather(CurrentWeatherModel weatherModel);
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cachedCurrentWeather(CurrentWeatherModel weatherModel) {
    CacheHelper.saveData(key: 'cached_weather', value: weatherModel.toString());
    return Future.value(unit);
  }

  @override
  Future<CurrentWeatherModel> getCachedCurrentWeather() {
    final shared = CacheHelper.getData(key: 'cached_weather');
    if (shared != null) {
      CurrentWeatherModel cachedWeather = CurrentWeatherModel.fromJson(shared);
      return Future.value(cachedWeather);
    } else {
      throw EmptyCacheException();
    }
  }
}
