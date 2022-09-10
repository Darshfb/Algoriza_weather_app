import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/error/failures.dart';
import 'package:weather/core/strings/strings.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';
import 'package:weather/features/weather/domain/use_cases/get_current_weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  final GetCurrentWeather currentWeather;

  WeatherCubit({
    required this.currentWeather,
  }) : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context);
// model
  void getWeatherData({String cityName = 'cairo'}) {
    emit(WeatherLoadingState());
    currentWeather.call(cityName: cityName).then((value) {
      // model = Model.fromJson(value.data);
      emit(value.fold(
          (failure) =>
              WeatherErrorState(error: _mapFailureToMsg(failure: failure)),
          (currentWeatherModel) =>
              WeatherSuccessState(weatherModel: currentWeatherModel)));
    });
  }

  String _mapFailureToMsg({required Failure failure}) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case EmptyCacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unExpectedError;
    }
  }
}
