import 'package:flutter/material.dart';

import '../../common/constants/app_colors.dart';
import '../../common/models/user_model.dart';
import '../../common/service/auth_service.dart';

import '../chat/data/user_repository.dart';
import 'components/custom_text_field.dart';
import 'components/loading.dart';
import 'sign_in.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final UserRepository _userRepository;
  String emailValidation = "";
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _userRepository = const UserRepositoryImp();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
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

  String? validateName(String? value) {
    if (value != null && value.isEmpty) {
      return "Username must be at least 1 character";
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
              elevation: 0,
              title: const Text(
                "Sign up to Fire Chat",
                style: TextStyle(color: AppColors.white),
              ),
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
                      color: AppColors.white,
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
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      validator: validateName,
                      controller: nameController,
                      hintText: "Write your username",
                    ),
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
                    Center(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            final UserModel? result =
                                await AuthService.registerWithEmailAndPassword(
                              passwordController.text.trim(),
                              emailController.text.trim(),
                              nameController.text.trim(),
                            );
                            if (result == null) {
                              setState(() {
                                loading = false;
                                emailValidation = "Please supply valid email";
                              });
                            } else {
                            
                              print(AuthService.currentUser?.uid);
                              _userRepository.addUser(result);
                            }
                          }
                        },
                        child: const Text(
                          "Register",
                        ),
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
