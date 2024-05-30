class Weather {
  final DateTime datetime;
  final num temperature;

  const Weather({
    required this.datetime,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      datetime: DateTime.parse((json['dt_txt'] ?? 0).toString()),
      temperature: json['main']?['temp'] ?? 0.0,
    );
  }
}
