import 'package:e_commerce_app/utils/app_routes.dart';
import 'package:e_commerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: .end,
        children: [
          BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                current is AuthLoggedOut || current is AuthLogoutError,
            buildWhen: (previous, current) => current is AuthLoggingOut,
            listener: (context, state) {
              if (state is AuthLoggedOut) {
                Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
                  AppRoutes.loginPageRoute,
                  (route) => false,
                );
              } else if (state is AuthLogoutError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is AuthLoggingOut) {
                return MainButton(isLoading: true);
              }
              return MainButton(
                title: 'Logout',
                onPressed: () async => await cubit.logout(),
              );
            },
          ),
        ],
      ),
    );
  }
}
