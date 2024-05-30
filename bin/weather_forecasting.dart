import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'model/weather.dart';

abstract class WeatherForecasting {
  static const apiKey = '3edcc3164571178f8c047768c89ab06b';

  /// ISO 3166 code Kota Jakarta
  static const String cityCode = 'jakarta,ID';

  /// Ramalan cuaca 5 hari ke depan
  static Future<void> forecastFiveNextDays() async {
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=$cityCode&appid=$apiKey&units=metric';

    try {
      // step 1: Hit API
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // case: Success
        // step 2: Parsing json
        Map<String, dynamic> jsonMap = jsonDecode(response.body);

        // step 3: Ambil data dari hasil parsing json
        var data = jsonMap['list'];

        // Cek apakah data berupa List
        if (data is List) {
          // Ambil datetime hari ini
          DateTime today = DateTime.now();

          // Siapkan penampung
          List<Weather> tempWeather = [];

          // Parsing dari json menjadi model Weather, kemudian masukkan ke penampung
          tempWeather = data.map((e) => Weather.fromJson(e)).toList();

          List<Weather> forecasting = [
            _groupByDay(tempWeather, today),
            _groupByDay(tempWeather, today.add(Duration(days: 1))),
            _groupByDay(tempWeather, today.add(Duration(days: 2))),
            _groupByDay(tempWeather, today.add(Duration(days: 3))),
            _groupByDay(tempWeather, today.add(Duration(days: 4))),
            _groupByDay(tempWeather, today.add(Duration(days: 5))),
          ];

          print('Weather Forecast:');

          forecasting.map((e) {
            print(
              '${DateFormat("E, d MMM yyyy").format(e.datetime)}: ${e.temperature.toStringAsFixed(2)}°C',
            );
          }).toString();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static Weather _groupByDay(List<Weather> weathers, DateTime datetime) {
    DateTime dayStart = DateTime(datetime.year, datetime.month, datetime.day);
    DateTime dayEnd = dayStart.add(Duration(days: 1));

    // Siapkan penampung
    List<Weather> tempWeathers = [];

    // Looping list weather
    for (Weather value in weathers) {
      if (value.datetime.isAfter(dayStart) && value.datetime.isBefore(dayEnd)) {
        tempWeathers.add(value);
      }
    }

    return Weather(
      datetime: DateTime(datetime.year, datetime.month, datetime.day),
      temperature: _calculateAverageTemperature(tempWeathers),
    );
  }

  /// Logic untuk menghitung temperature rata-rata dalam satu hari
  static double _calculateAverageTemperature(List<Weather> weathers) {
    // step 1: Ambil data temperature dari semua timestamp
    final temperatures = weathers.map((e) => e.temperature).toList();

    // step 2: Siapkan penampung
    double tempAverage = 0.0;

    // step 3: Iterasi nilai dari dalam list temperature
    for (num value in temperatures) {
      tempAverage += value;
    }

    // step 4: Bagi dengan jumlah temperature untuk mendapat nilai rata-rata
    tempAverage = tempAverage / temperatures.length;

    // step 5: Return nilai rata-rata
    return tempAverage;
  }
}
