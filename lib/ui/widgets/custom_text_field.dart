import 'package:final_project/utils/app_colors.dart';
import 'package:flutter/material.dart';

typedef OnChanged = void Function(String)?;
typedef OnValidator = String? Function(String?)?;

class CustomTextField extends StatelessWidget {
  final Color? borderColor;
  final Color? cursorColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? style;
  final TextEditingController? controller;
  final OnChanged onChanged;
  final OnValidator validator;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final int? maxLines;
  final String? obscuringCharacter;

  const CustomTextField({
    super.key,
    this.borderColor,
    this.cursorColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.obscureText,
    this.maxLines,
    this.obscuringCharacter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor ?? AppColors.mainLightColor,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      style: style,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      obscuringCharacter: obscuringCharacter ?? '*',
      decoration: InputDecoration(
        enabledBorder: _buildDecorationBorder(
          borderColor: borderColor ?? Theme.of(context).highlightColor,
        ),
        focusedBorder: _buildDecorationBorder(
          borderColor: borderColor ?? Theme.of(context).highlightColor,
        ),
        errorBorder: _buildDecorationBorder(borderColor: AppColors.redColor),
        focusedErrorBorder: _buildDecorationBorder(
          borderColor: AppColors.redColor,
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle: hintStyle,
        labelStyle: labelStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  OutlineInputBorder _buildDecorationBorder({required Color borderColor}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 2, color: borderColor),
    );
  }
}
