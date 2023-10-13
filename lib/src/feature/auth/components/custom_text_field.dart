import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.obscure = false,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscure,
      cursorColor: AppColors.secondaryColor,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: AppColors.secondaryColor,
            width: 1,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 1,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          borderSide: BorderSide(
            color: AppColors.red,
            width: 1,
          ),
        ),
      ),
    );
  }
}
