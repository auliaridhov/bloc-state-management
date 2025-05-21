import '../../models/user_model.dart';

abstract class UserDetailState {}

class UserDetailInitial extends UserDetailState {}

class UserDetailLoading extends UserDetailState {}

class UserDetailLoaded extends UserDetailState {
  final User user;
  UserDetailLoaded(this.user);
}

class UserDetailError extends UserDetailState {
  final String message;
  UserDetailError(this.message);
}
