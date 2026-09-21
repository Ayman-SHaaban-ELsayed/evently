import 'package:final_project/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomDateTimeWidget extends StatelessWidget {
  const CustomDateTimeWidget({
    super.key,
    required this.icon,
    required this.eventDateOrTime,
    required this.onPressed,
    required this.chooseDateOrTime,
  });

  final Widget icon;
  final String eventDateOrTime;
  final VoidCallback onPressed;
  final String chooseDateOrTime;

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * .02),
      child: Row(
        spacing: width * .04,
        children: [
          icon,
          Text(
            eventDateOrTime,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Spacer(),
          TextButton(
            onPressed: onPressed,
            child: Text(
              chooseDateOrTime,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                decorationColor: Theme.of(context).cardColor,
                decoration: TextDecoration.underline,
                decorationThickness: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
