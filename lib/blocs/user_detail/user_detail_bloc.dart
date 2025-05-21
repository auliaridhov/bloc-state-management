import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repository.dart';
import 'user_detail_event.dart';
import 'user_detail_state.dart';

class UserDetailBloc extends Bloc<UserDetailEvent, UserDetailState> {
  final UserRepository repository;

  UserDetailBloc(this.repository) : super(UserDetailInitial()) {
    on<LoadUserDetail>((event, emit) async {
      emit(UserDetailLoading());
      try {
        final user = await repository.fetchUserDetail(event.userId);
        emit(UserDetailLoaded(user));
      } catch (e, st) {
        print('Error fetching user detail: $e\n$st');
        emit(UserDetailError(e.toString()));
      }
    });
  }
}
