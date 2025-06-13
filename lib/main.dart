import 'package:bloctutorial/blocs/login/login_bloc.dart';
import 'package:bloctutorial/blocs/user_detail/user_detail_bloc.dart';
import 'package:bloctutorial/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart/cart_bloc.dart';
import 'models/user_model.dart';
import 'models/weather_model.dart';
import 'repositories/user_repository.dart';
import 'repositories/weather_repository.dart';
import 'blocs/user/user_bloc.dart';
import 'blocs/weather/weather_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(WeatherAdapter());

  await Hive.openBox<User>('users');
  await Hive.openBox<Weather>('weather');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final userRepo = UserRepository();
  final weatherRepo = WeatherRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (_) => UserBloc(userRepo)),
        BlocProvider<WeatherBloc>(create: (_) => WeatherBloc(weatherRepo)),
        BlocProvider<UserDetailBloc>(create: (_) => UserDetailBloc(userRepo)),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'Multi-BLoC Demo',
        home: LoginScreen(),
      ),
    );
  }
}
