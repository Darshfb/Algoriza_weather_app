class CurrentWeatherModel {
  LocationModel? locationModel;
  CurrentWeather? currentWeather;
  ForecastWeather? forecastWeather;

  CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    locationModel = LocationModel.fromJson(json['location']);
    currentWeather = CurrentWeather.fromJson(json['current']);
    forecastWeather = ForecastWeather.fromJson(json['forecast']);
  }
}

class LocationModel {
  String? name;
  String? region;
  String? country;
  String? localtime;
  int? localtimeEpoch;

  LocationModel({
    required this.name,
    required this.region,
    required this.country,
    required this.localtime,
  });

  LocationModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    region = json['region'];
    country = json['country'];
    localtime = json['localtime'];
    localtimeEpoch = json['localtime_epoch'];
  }
}

class CurrentWeather {
  double? tempC;
  String? text;
  String? icon;
  double? windKph;
  double? feelsLike;
  int? humidity;

  CurrentWeather.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    text = json['condition']['text'];
    icon = json['condition']['icon'];
    windKph = json['wind_kph'];
    humidity = json['humidity'];
    feelsLike = json['feelslike_c'];
  }
}

class ForecastWeather {
  List<ForecastDay> forecast = [];

  ForecastWeather.fromJson(Map<String, dynamic> json) {
    json['forecastday'].forEach((e) {
      forecast.add(ForecastDay.fromJson(e));
    });
  }
}

class ForecastDay {
  String? date;
  int? dateEpoch;
  Day? day;
  Astro? astro;
  List<ForecastHour>? hours;

  ForecastDay.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    dateEpoch = json['date_epoch'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    astro = json['astro'] != null ? Astro.fromJson(json['astro']) : null;
    if (json['hour'] != null) {
      hours = <ForecastHour>[];
      json['hour'].forEach((v) {
        hours!.add(ForecastHour.fromJson(v));
      });
    }
    // json['hour'].forEach((element) {
    //   hours!.add(ForecastHour.fromJson(element));
    // });
  }
}

class Day {
  double? maxTempC;
  double? minTempC;
  double? avgTempC;
  String? icon;
  String? text;

  Day.fromJson(Map<String, dynamic> json) {
    maxTempC = json['maxtemp_c'];
    minTempC = json['mintemp_c'];
    avgTempC = json['avgtemp_c'];
    icon = json['condition']['text'];
    icon = json['condition']['icon'];
  }
}

class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonSet;
  String? moonPhase;

  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    moonrise = json['moonrise'];
    moonSet = json['moonset'];
    moonPhase = json['moon_phase'];
  }
}

class ForecastHour {
  String? time;
  double? tempC;
  double? tempF;
  String? text;
  String? icon;
  int? humidity;
  double? windKph;
  double? feelsLike;

  ForecastHour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    windKph = json['wind_kph'];
    humidity = json['humidity'];
    feelsLike = json['feelslike_c'];
    text = json['condition']['time'];
    icon = json['condition']['time'];
  }
}


// class ForeCastMain {
//   List<ForecastDay> forecastDay = [];
//
//   ForeCastMain.fromJson(Map<String, dynamic> json) {
//     json['forecastday'].forEach((e) {
//       forecastDay.add(ForecastDay.fromJson(e));
//     });
//   }
// }