import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weather/core/strings/colors.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';
import 'package:weather/features/weather/presentation/bloc/weather_cubit.dart';

class MyChart extends StatelessWidget {
  const MyChart({
    super.key,
    required this.forecastHour,
  });

  final List<ForecastHour> forecastHour;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherStates>(
      builder: (BuildContext context, state) {
        if (state is WeatherSuccessState) {
          var weather = state.weatherModel;
          // List<ForecastDay>? hours = weather.forecastWeather!.forecast;
          return SizedBox(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 200,
            child: Card(
              elevation: 5,
              color: AppColors.secondaryColor,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 14.0,
                    ),
                    Expanded(
                      child: SfCartesianChart(
                        backgroundColor: AppColors.secondaryColor,
                        borderColor: Colors.transparent,
                        plotAreaBorderColor: Colors.transparent,
                        plotAreaBackgroundColor: Colors.transparent,
                        primaryXAxis: CategoryAxis(),
                        series: <ChartSeries<ForecastHour, dynamic>>[
                          SplineSeries<ForecastHour, dynamic>(
                            color: Colors.white,
                            dataSource: forecastHour,
                            yValueMapper: (ForecastHour f, _) => f.tempC,
                            xValueMapper: (ForecastHour f, _) =>
                            f.time!.split(' ')[1],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Text('');
        }
      },
    );
  }
}
