import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_detail/user_detail_bloc.dart';
import '../blocs/user_detail/user_detail_event.dart';
import '../blocs/user_detail/user_detail_state.dart';
import '../repositories/user_repository.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;
  const UserDetailScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Detail')),
      body: BlocProvider(
        create: (context) => UserDetailBloc(UserRepository())..add(LoadUserDetail(userId)),
        child: BlocBuilder<UserDetailBloc, UserDetailState>(
          builder: (context, state) {
            if (state is UserDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserDetailLoaded) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${user.name}", style: TextStyle(fontSize: 18)),
                    Text("Email: ${user.email}"),
                    Text("Phone: ${user.phone}"),
                    Text("Website: ${user.website}"),
                    Text("Company: ${user.company?['name'] ?? ''}"),
                    Text("City: ${user.address?['city'] ?? ''}"),
                  ],
                ),
              );
            } else if (state is UserDetailError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
