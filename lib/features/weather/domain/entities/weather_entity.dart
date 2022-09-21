import 'package:equatable/equatable.dart';
import 'package:weather/features/weather/data/models/weather_model.dart';

class WeatherEntity extends Equatable {
  final Location location;

  // final Forecast forecast;

  const WeatherEntity(this.location);

  @override
  List<Object> get props => [
        location,
      ];
}

class Location extends Equatable {
  final String name;
  final String region;
  final int country;
  final String localtimeEpoch;

  const Location({
    required this.name,
    required this.region,
    required this.country,
    required this.localtimeEpoch,
  });

  @override
  List<Object> get props => [
        name,
        region,
        country,
        localtimeEpoch,
      ];
}

class ForecastEntity extends Equatable {
  final List<ForecastDay> list;

  const ForecastEntity({required this.list});

  @override
  List<Object> get props => [list];
}

class ForecastModel extends ForecastEntity {
  const ForecastModel({required super.list});

// extends from entity
  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    // parsing a list
    return ForecastModel(
        list:
        List<ForecastDayModel>.from((json['ss'] as List).map((e) => ForecastDayModel.fromJson(e))));
  }
}

class ForecastDay extends Equatable {
  final String data;
  final String dateEpoch;

  const ForecastDay({required this.data, required this.dateEpoch});

  @override
  List<Object> get props => [
        data,
        dateEpoch,
      ];
}

class ForecastDayModel extends ForecastDay {
  const ForecastDayModel({required super.data, required super.dateEpoch});

  factory ForecastDayModel.fromJson(Map<String, dynamic> json) {
    return ForecastDayModel(data: json['data'], dateEpoch: json['epoch']);
  }
}

class WeatherHourly extends Equatable {
  final String time;
  final String tempC;
  final String tempF;
  final String text;
  final String icon;

  const WeatherHourly({
    required this.time,
    required this.tempC,
    required this.tempF,
    required this.text,
    required this.icon,
  });

  @override
  List<Object?> get props => [
        time,
        tempC,
        tempF,
        text,
        icon,
      ];
}

class WeatherModel extends WeatherEntity {
  const WeatherModel(super.location);

// factory WeatherModel.fromJson(Map<String, dynamic> json) {
//   return WeatherModel(LocationModel.fromJson(json['location']), Forecast.);
// }
}

class LocationModel extends Location {
  const LocationModel({
    required super.name,
    required super.region,
    required super.country,
    required super.localtimeEpoch,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      localtimeEpoch: json['localtimeEpoch'],
    );
  }
}
