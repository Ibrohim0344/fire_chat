import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/service/auth_service.dart';
import '../home/home_screen.dart';
import 'components/custom_text_field.dart';
import 'components/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  String emailValidation = "";
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value != null && value.isEmpty) {
      return "Please supply valid email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value != null && value.length < 8) {
      return "Enter password at least 8 characters";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.secondaryColor,
              leading: BackButton(
                color: AppColors.mainColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              elevation: 0,
              title: const Text(
                "Sign in to Crew Brew",
                style: TextStyle(color: AppColors.white),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      validator: validateEmail,
                      controller: emailController,
                      hintText: "Write your email",
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      validator: validatePassword,
                      controller: passwordController,
                      hintText: "Write Your password",
                      obscure: true,
                    ),
                    const SizedBox(height: 15),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          final result =
                              await AuthService.signInWithEmailAndPassword(
                            passwordController.text.trim(),
                            emailController.text.trim(),
                          );

                          if (result != null && mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          } else {
                            setState(
                              () {
                                loading = false;
                                emailValidation =
                                    "Could not sign in with those credentials";
                              },
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Sign In",
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      emailValidation,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
