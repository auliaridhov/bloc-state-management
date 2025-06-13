import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 1)
class Weather extends Equatable {
  @HiveField(0)
  final double temperature;

  @HiveField(1)
  final double windspeed;

  const Weather({required this.temperature, required this.windspeed});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'];
    return Weather(
      temperature: current['temperature']?.toDouble() ?? 0.0,
      windspeed: current['windspeed']?.toDouble() ?? 0.0,
    );
  }

  @override
  List<Object?> get props => [temperature, windspeed];
}
