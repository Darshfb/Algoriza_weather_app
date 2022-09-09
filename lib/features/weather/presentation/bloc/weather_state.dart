part of 'weather_cubit.dart';

abstract class WeatherStates {}

class WeatherInitial extends WeatherStates {}

class WeatherLoadingState extends WeatherStates {}

class WeatherSuccessState extends WeatherStates {
  final CurrentWeatherModel weatherModel;

  WeatherSuccessState({required this.weatherModel});
}

class WeatherErrorState extends WeatherStates {
  final String error;

  WeatherErrorState({required this.error});
}

class WeatherScrollControllerState extends WeatherStates{}