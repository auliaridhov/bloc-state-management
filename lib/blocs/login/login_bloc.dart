import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      await Future.delayed(Duration(seconds: 2)); // fake network delay

      // Simulated login check
      if (event.email == 'tes' && event.password == 'tes') {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Invalid credentials"));
      }
    });
  }
}
