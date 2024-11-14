import 'dart:async';

import 'package:architecture_studying/domain/data_providers/user_data_providers.dart';
import 'package:architecture_studying/domain/entity/user.dart';

class UserState {
  final User currentuser;

  UserState({
    required this.currentuser,
  });

  UserState copyWith({
    User? currentuser,
  }) {
    return UserState(
      currentuser: currentuser ?? this.currentuser,
    );
  }

  @override
  String toString() => 'UserState(currentuser: $currentuser)';

  @override
  bool operator ==(covariant UserState other) {
    if (identical(this, other)) return true;

    return other.currentuser == currentuser;
  }

  @override
  int get hashCode => currentuser.hashCode;
}

class Userbloc {
  final _userDataProvider = UserDataProviders();
  var _state = UserState(currentuser: User(0));
  UserState get state => _state;
  final _stateController = StreamController<UserState>.broadcast();
  Stream<UserState> get stream => _stateController.stream;

  Userbloc() {
    initialize();
  }

  void updateState(UserState state) {
    if (_state == state) return;
    _state = state;
    _stateController.add(state);
  }

  Future<void> initialize() async {
    final user = await _userDataProvider.loadValue();
    updateState(_state.copyWith(currentuser: user));
  }

  void increment() {
    var user = _state.currentuser;
    user = user.copyWith(age: user.age + 1);
    updateState(_state.copyWith(currentuser: user));
    _userDataProvider.saveValue(user);
  }

  void decrement() {
    var user = _state.currentuser;
    user = user.copyWith(age: user.age - 1);
    updateState(_state.copyWith(currentuser: user));
    _userDataProvider.saveValue(user);
  }
}
