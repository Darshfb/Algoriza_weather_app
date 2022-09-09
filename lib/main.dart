import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/app_theme/app_theme.dart';
import 'package:weather/features/weather/presentation/bloc/weather_cubit.dart';
import 'package:weather/features/weather/presentation/screens/home_screen.dart';
import 'package:weather/features/weather/presentation/screens/test_screeen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // DioHelper();
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // NetworkInfo networkInfo =
  //     NetworkInfoImpl(connectionChecker: InternetConnectionChecker());
  // WeatherRemoteDataSource remoteDataSource = WeatherRemoteDataSourceImpl();
  // WeatherRepository repository = WeatherRepositoryImpl(
  //     remoteDataSource: remoteDataSource, networkInfo: networkInfo);
  // GetCurrentWeather(repository: repository).call(cityName: 'Alexandria');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => di.sl<WeatherCubit>()..getWeatherData(),)
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: appTheme,
        home: const TestScreen(),
      ),
    );
  }
}
