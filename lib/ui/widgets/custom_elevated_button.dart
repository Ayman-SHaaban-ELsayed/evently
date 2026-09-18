import 'package:final_project/utils/app_colors.dart';
import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? padding;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    var height = context.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
          side: BorderSide(
            width: 2,
            color: borderColor ??AppColors.transparentColor,
          ),
        ),

        padding: EdgeInsets.symmetric(vertical: height * 0.02),

        backgroundColor: backgroundColor ?? Theme.of(context).cardColor,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
