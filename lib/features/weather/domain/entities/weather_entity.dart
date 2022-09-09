// import 'package:equatable/equatable.dart';
//
// class WeatherEntity extends Equatable {
//   final Location location;
//   final Forecast forecast;
//
//   const WeatherEntity(this.location, this.forecast);
//
//   @override
//   List<Object> get props => [
//         location,
//         forecast,
//       ];
// }
//
// class Location extends Equatable {
//   final String name;
//   final String region;
//   final int country;
//   final String localtimeEpoch;
//
//   const Location({
//     required this.name,
//     required this.region,
//     required this.country,
//     required this.localtimeEpoch,
//   });
//
//   @override
//   List<Object> get props => [
//         name,
//         region,
//         country,
//         localtimeEpoch,
//       ];
// }
//
// class Forecast extends Equatable {
//   final List<ForecastDay> list;
//
//   const Forecast(this.list);
//
//   @override
//   List<Object> get props => [list];
// }
//
// class ForecastDay extends Equatable {
//   final String data;
//   final String dateEpoch;
//
//   const ForecastDay({required this.data, required this.dateEpoch});
//
//   @override
//   List<Object> get props => [
//         data,
//         dateEpoch,
//       ];
// }
//
// class WeatherHourly extends Equatable {
//   final String time;
//   final String tempC;
//   final String tempF;
//   final String text;
//   final String icon;
//
//   const WeatherHourly({
//     required this.time,
//     required this.tempC,
//     required this.tempF,
//     required this.text,
//     required this.icon,
//   });
//
//   @override
//   List<Object?> get props => [
//         time,
//         tempC,
//         tempF,
//         text,
//         icon,
//       ];
// }
//
// class WeatherModel extends WeatherEntity {
//   const WeatherModel(super.location, super.forecast);
//
//   factory WeatherModel.fromJson(Map<String, dynamic> json) {
//     return WeatherModel(LocationModel.fromJson(json['location']), forecast);
//   }
// }
//
// class LocationModel extends Location {
//   const LocationModel({
//     required super.name,
//     required super.region,
//     required super.country,
//     required super.localtimeEpoch,
//   });
//
//   factory LocationModel.fromJson(Map<String, dynamic> json) {
//     return LocationModel(
//       name: json['name'],
//       region: json['region'],
//       country: json['country'],
//       localtimeEpoch: json['localtimeEpoch'],
//     );
//   }
// }
