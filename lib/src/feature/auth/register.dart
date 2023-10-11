import 'package:flutter/material.dart';

import '../../common/models/user_model.dart';
import '../../common/service/auth_service.dart';

import 'components/custom_text_field.dart';
import 'components/loading.dart';
import 'sign_in.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            backgroundColor: Colors.brown.shade100,
            appBar: AppBar(
              backgroundColor: Colors.brown,
              elevation: 0,
              title: const Text("Sign up to Crew Brew"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ),
                    );
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
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
                      obsecure: true,
                    ),
                    const SizedBox(height: 15),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.brown,
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          final UserModel? result =
                              await AuthService.registerWithEmailAndPassword(
                            passwordController.text,
                            emailController.text,
                          );
                          if (result == null) {
                            setState(() {
                              loading = false;
                              emailValidation = "Please supply valid email";
                            });
                          }
                        }
                      },
                      child: const Text(
                        "Register",
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
