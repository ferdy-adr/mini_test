import 'foobar.dart';
import 'weather_forecasting.dart';

void main(List<String> arguments) async {
  // Test 1: FooBar
  FooBar.run();

  print('\n');

  // Test 2: Weather forecasting for 5 next days
  await WeatherForecasting.forecastFiveNextDays();
}
