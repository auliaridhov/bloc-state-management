import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloctutorial/blocs/weather/weather_bloc.dart';
import 'package:bloctutorial/blocs/weather/weather_event.dart';
import 'package:bloctutorial/blocs/weather/weather_state.dart';
import 'package:bloctutorial/models/weather_model.dart';

import 'mocks/mocks.mocks.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('WeatherBloc', () {
    late MockWeatherRepository mockWeatherRepository;
    late WeatherBloc weatherBloc;

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      weatherBloc = WeatherBloc(mockWeatherRepository);
    });

    tearDown(() {
      weatherBloc.close();
    });

    test('initial state is WeatherInitial', () {
      expect(weatherBloc.state, WeatherInitial());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when LoadWeather is added',
      build: () {
        when(mockWeatherRepository.fetchWeather()).thenAnswer(
              (_) async => Weather(temperature: 25, windspeed: 10),
        );
        return weatherBloc;
      },
      act: (bloc) => bloc.add(LoadWeather()),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(Weather(temperature: 25, windspeed: 10)),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when repository throws',
      build: () {
        when(mockWeatherRepository.fetchWeather())
            .thenThrow(Exception('Failed'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(LoadWeather()),
      expect: () => [
        WeatherLoading(),
        isA<WeatherError>(),
      ],
    );
  });
}
