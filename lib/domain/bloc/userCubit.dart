import 'package:architecture_studying/domain/data_providers/user_data_providers.dart';
import 'package:architecture_studying/domain/entity/user.dart';
import 'package:bloc/bloc.dart';

class userState {
  final User userCurrent;

  userState({
    required this.userCurrent,
  });

  userState copyWith({
    User? userCurrent,
  }) {
    return userState(
      userCurrent: userCurrent ?? this.userCurrent,
    );
  }

  @override
  String toString() => 'userState(userCurrent: $userCurrent)';

  @override
  bool operator ==(covariant userState other) {
    if (identical(this, other)) return true;

    return other.userCurrent == userCurrent;
  }

  @override
  int get hashCode => userCurrent.hashCode;
}

class Usercubit extends Cubit<userState> {
  final _userDataProviders = UserDataProviders();

  Usercubit() : super(userState(userCurrent: User(0))) {
    _initialize();
  }

  void _initialize() async {
    final user = await _userDataProviders.loadValue();
    emit(state.copyWith(userCurrent: user));
  }

  void increment() {
    var user = state.userCurrent;
    user = user.copyWith(age: user.age + 1);
    emit(state.copyWith(userCurrent: user));
    _userDataProviders.saveValue(user);
  }

  void decrement() {
    var user = state.userCurrent;
    user = user.copyWith(age: user.age - 1);
    emit(state.copyWith(userCurrent: user));
    _userDataProviders.saveValue(user);
  }
}
