import 'package:flutter/material.dart';

import '../blocs/user_bloc.dart';
import '../blocs/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Page"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  leading: Image.network(user.avatar),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                );
              },
            );
          } else if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
