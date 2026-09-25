import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static Future<bool?> toastMgs({
    required String msg,
    required Color backgroundColor,
    required Color textColor,
    ToastGravity gravity = ToastGravity.CENTER,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
  toastLength: Toast.LENGTH_LONG,    gravity: gravity,
      timeInSecForIosWeb: 3,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: 16.0,
    );
  }
}
