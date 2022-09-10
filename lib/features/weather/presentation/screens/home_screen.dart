import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/strings/colors.dart';
import 'package:weather/features/weather/presentation/bloc/weather_cubit.dart';
import 'package:weather/features/weather/presentation/screens/test_screeen.dart';
import 'package:weather/features/weather/presentation/widgets/app_drawer.dart';
import 'package:weather/test/my_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80.0,
        elevation: 0,
        title: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return const TestScreen();
              }));
              // WeatherCubit.get(context).getWeatherData(cityName: 'Alexandria');
            },
            icon: const Icon(
              Icons.add,
            )),
      ),
      backgroundColor: AppColors.primaryColor,
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: BlocConsumer<WeatherCubit, WeatherStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            if (state is WeatherSuccessState) {
              var weather = state.weatherModel;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${weather.currentWeather!.tempC}\u00B0',
                                style: const TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 6.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${weather.locationModel!.name}',
                                    style: const TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  const Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                '${weather.forecastWeather!.forecast[0].day!.minTempC}\u00B0 / ${weather.forecastWeather!.forecast[0].day!.maxTempC}\u00B0 Feels like ${weather.currentWeather!.feelsLike}\u00B0',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                              const SizedBox(
                                height: 3.0,
                              ),
                              Text(
                                '${DateFormat('EE d MMM hh:mm').format(DateTime.fromMillisecondsSinceEpoch(1662508800 * 1000)).split(' ')[0]}, ${weather.locationModel!.localtime!.split(' ')[1]}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          Image(
                            image: NetworkImage(
                                'https:${weather.currentWeather!.icon}'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    MyChart(
                      forecastHour: weather.forecastWeather!.forecast[0].hours!,
                    ),
                    Card(
                      elevation: 5,
                      color: AppColors.secondaryColor,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 16.0,
                          bottom: 16.0,
                        ),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  weather.forecastWeather!.forecast.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item =
                                    weather.forecastWeather!.forecast[index];
                                return SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          DateFormat('EEEE').format(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  item.dateEpoch! * 1000)),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Image(
                                        image: NetworkImage(
                                            'https:${item.day!.icon}'),
                                        fit: BoxFit.contain,
                                        width: 25,
                                        height: 25,
                                      )),
                                      Expanded(
                                        child: Text(
                                          '${item.day!.minTempC!.toInt()}',
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${item.day!.maxTempC!.toInt()}',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: AppColors.secondaryColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Sunrise',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${weather.forecastWeather!.forecast[0].astro!.sunrise}',
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/sunrisesss.gif'),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Sunset',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${weather.forecastWeather!.forecast[0].astro!.sunrise}',
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/anime-sunset.gif'),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      color: AppColors.secondaryColor,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Wind',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${weather.currentWeather!.windKph}',
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/wind.gif'),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                color: Colors.grey,
                                width: 1.5,
                                height: 80,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text(
                                    'Humidly',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    '${weather.currentWeather!.humidity}',
                                    style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/humidly.gif'),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is WeatherLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text('There is An Error'),
              );
            }
          },
        ),
      ),
    );
  }
}
