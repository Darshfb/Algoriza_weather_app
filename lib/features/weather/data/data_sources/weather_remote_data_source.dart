import 'dart:developer';

import 'package:weather/core/error/exceptions.dart';
import 'package:weather/core/shared/Network/dio_helper.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<CurrentWeatherModel> getCurrentWeather({required String cityName});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  @override
  Future<CurrentWeatherModel> getCurrentWeather(
      {required String cityName}) async {
    final response = await DioHelper.getData(url: '/v1/forecast.json', query: {
      "key": "ca77d57262b842c9a42165542220409",
      "q": cityName,
      "days": "7",
      "aqi": "no",
      "alerts": "no",
    });
    if (response.statusCode == 200) {
      final data = response.data;
      final CurrentWeatherModel weatherModel =
          CurrentWeatherModel.fromJson(data);
      log(data.toString());
      return weatherModel;
    } else {
      throw ServerException();
    }
  }
}
