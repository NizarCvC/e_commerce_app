import 'package:e_commerce_app/utils/app_routes.dart';
import 'package:e_commerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/main_button.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/label_with_text_field.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: size.height * 0.015),
                Text(
                  'Login Account',
                  style: textTheme.headlineMedium!.copyWith(fontWeight: .w600),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  'Please login with registered',
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      LabelWithTextField(
                        context: context,
                        controller: _emailOrPhoneController,
                        title: 'Email or Phone Number',
                        hintText: 'Enter your email or phone number',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: size.height * 0.04),
                      LabelWithTextField(
                        context: context,
                        controller: _passwordController,
                        title: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.grey[500],
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.visibility_outlined,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: .centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Forgot Password?'),
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Column(
                  children: [
                    BlocConsumer<AuthCubit, AuthState>(
                      bloc: cubit,
                      listenWhen: (previous, current) =>
                          current is AuthSuccess || current is AuthError,
                      buildWhen: (previous, current) =>
                          current is AuthLoading ||
                          current is AuthSuccess ||
                          current is AuthError,
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          Navigator.of(context).pushNamed(AppRoutes.homeRoute);
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return MainButton(
                            isLoading: true,
                            hight: size.height * 0.06,
                          );
                        }
                        return MainButton(
                          title: 'Login',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await cubit.loginWithEmailAndPassword(
                                _emailOrPhoneController.text,
                                _passwordController.text,
                              );
                              // Navigator.of(context).pushNamed(AppRoutes.homeRoute);
                            }
                          },
                          hight: size.height * 0.06,
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.createAccountPageRoute);
                      },
                      child: Text('Don\'t have an account? Register'),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Or using other method',
                      style: textTheme.titleMedium!.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    SocialMediaButton(
                      text: 'Sign In with Google',
                      imageUrl:
                          'https://image.similarpng.com/file/similarpng/original-picture/2020/06/Logo-google-icon-PNG.png',
                      onTap: () {},
                    ),
                    SizedBox(height: size.height * 0.02),
                    SocialMediaButton(
                      text: 'Sign In with Facebook',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/960px-2021_Facebook_icon.svg.png',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
