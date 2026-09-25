import 'package:flutter/material.dart';

class MainErrorWidget extends StatelessWidget {
  const MainErrorWidget({super.key, required this.errorMessage});
final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(errorMessage,style: Theme.of(context).textTheme.headlineMedium,));
  }
}
