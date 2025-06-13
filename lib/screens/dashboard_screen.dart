import 'package:bloctutorial/screens/product_list_page.dart';
import 'package:bloctutorial/widgets/clock_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user/user_bloc.dart';
import '../blocs/user/user_event.dart';
import '../blocs/user/user_state.dart';
import '../blocs/weather/weather_bloc.dart';
import '../blocs/weather/weather_event.dart';
import '../blocs/weather/weather_state.dart';
import '../screens/user_detail_screen.dart';
import '../blocs/user_detail/user_detail_bloc.dart';
import '../repositories/user_repository.dart';

class DashboardScreen extends StatefulWidget {

  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final userRepo = UserRepository();
  int count = 1;

  @override
  void initState() {
    super.initState();
    // Dispatch events right after widget is initialized
    // Delay with addPostFrameCallback to ensure context is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserBloc>().add(LoadUsers());
      context.read<WeatherBloc>().add(LoadWeather());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<WeatherBloc>().add(LoadWeather());
          context.read<UserBloc>().add(LoadUsers());
          await Future.delayed(Duration(milliseconds: 500));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(), // Ensure scroll even if content is short
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Weather Section
              ClockWidget(),
              SizedBox(height: 8),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ProductListPage()));
                },
                  child: Text('GOTO PRODUCT LIST', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              SizedBox(height: 8),
              Text('Weather Info', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is WeatherLoaded) {
                    return Text(
                      'Temp: ${state.weather.temperature}°C\nWind: ${state.weather.windspeed} km/h',
                      style: TextStyle(fontSize: 16),
                    );
                  } else if (state is WeatherError) {
                    return Text('Error: ${state.message}');
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<WeatherBloc>().add(LoadWeather());
                      },
                      child: Text('Load Weather'),
                    );
                  }
                },
              ),
              SizedBox(height: 30),

              /// Users Section
              Row(
                  children: [
                    Text('Users List', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          count++;
                        });
                      },
                        child: Text(count.toString())
                    ),
                  ]
              ),
              SizedBox(height: 8),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is UserLoaded) {
                    if (state.users.isEmpty) {
                      return Text("No users found.");
                    }

                    return ListView.builder(
                      shrinkWrap: true, physics: NeverScrollableScrollPhysics(), // Parent scroll handles it
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (context) => UserDetailBloc(userRepo),
                                  child: UserDetailScreen(userId: user.id),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is UserError) {
                    return Text('Error: ${state.message}');
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        context.read<UserBloc>().add(LoadUsers());
                      },
                      child: Text('Load Users'),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
