import 'package:e_commerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/label_with_text_field.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/main_button.dart';
import 'package:e_commerce_app/views/widgets/custom_widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _usernameController = TextEditingController();
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
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  'Create Account',
                  style: textTheme.headlineMedium!.copyWith(fontWeight: .w600),
                ),
                SizedBox(height: size.height * 0.008),
                Text(
                  'Start shopping with create your account',
                  style: textTheme.titleMedium!.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      LabelWithTextField(
                        context: context,
                        controller: _usernameController,
                        title: 'Username',
                        hintText: 'Create your username',
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      LabelWithTextField(
                        context: context,
                        controller: _emailOrPhoneController,
                        title: 'Email or Phone Number',
                        hintText: 'Create your email or phone number',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      LabelWithTextField(
                        context: context,
                        controller: _passwordController,
                        title: 'Password',
                        hintText: 'Create your password',
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
                SizedBox(height: size.height * 0.04),
                Column(
                  children: [
                    BlocConsumer<AuthCubit, AuthState>(
                      listenWhen: (previous, current) =>
                          current is AuthSuccess || current is AuthError,
                      buildWhen: (previous, current) =>
                          current is AuthLoading ||
                          current is AuthSuccess ||
                          current is AuthError,
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          Navigator.pop(context);
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
                          title: 'Create Account',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await cubit.registerWithPhoneAndPassword(
                                _emailOrPhoneController.text,
                                _passwordController.text,
                              );
                            }
                          },
                          hight: size.height * 0.06,
                        );
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Do you have an account?'),
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
                      text: 'Sign Up with Google',
                      imageUrl:
                          'https://image.similarpng.com/file/similarpng/original-picture/2020/06/Logo-google-icon-PNG.png',
                      onTap: () {},
                    ),
                    SizedBox(height: size.height * 0.02),
                    SocialMediaButton(
                      text: 'Sign Up with Facebook',
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
