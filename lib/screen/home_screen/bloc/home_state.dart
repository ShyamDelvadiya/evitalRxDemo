part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

class UserLoadingState extends HomeState {}

class UserLoadedState extends HomeState {
  final List<UserModel> users;

  UserLoadedState({required this.users});
}

class UserFilteredState extends HomeState {
  final List<UserModel> filteredUsers;

  UserFilteredState(this.filteredUsers);
}
class UserPageLoadingState extends HomeState {
  final List<UserModel> users;

  UserPageLoadingState({required this.users});
}