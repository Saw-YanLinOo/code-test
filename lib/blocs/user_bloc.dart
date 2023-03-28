import 'package:code_test/blocs/user_event.dart';
import 'package:code_test/blocs/user_state.dart';
import 'package:code_test/models/user_model.dart';
import 'package:code_test/repositories/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  final UserRepository userRepository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<UserLoadedEvent>((event, emit) async {
      emit(UserLoading());
      final users = await userRepository.getUsers();
      emit(UserLoaded(users: users));
    });
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    try {
      final users = (json['data'] as List)
          .map((json) => UserModel.fromJson(json))
          .toList();
      return UserLoaded(users: users);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserLoaded) {
      return {'data': state.users.map((user) => user.toJson()).toList()};
    } else {
      return null;
    }
  }
}
