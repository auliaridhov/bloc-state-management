import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../models/weather_model.dart';

class WeatherRepository {
  final Box<Weather> _box = Hive.box<Weather>('weather');

  Future<Weather> fetchWeather() async {
    try {
      // final url = 'https://api.open-meteo.com/v1/forecast?latitude=35&longitude=139&current_weather=true';
      // final response = await http.get(Uri.parse(url));
      //
      // if (response.statusCode == 200) {
      //   final jsonData = json.decode(response.body);
      //   final weather = Weather.fromJson(jsonData);
      //
      //   await _box.clear();
      //   await _box.add(weather);
      //
      //   return weather;
      // } else {
      //   throw Exception('Network error');
      // }

      return Weather(temperature: 0.0, windspeed: 0.0);
    } catch (_) {
      if (_box.isNotEmpty) {
        return _box.values.first;
      } else {
        throw Exception('No data available');
      }
    }
  }
}
