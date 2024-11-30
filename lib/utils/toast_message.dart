import 'package:fluttertoast/fluttertoast.dart';

Future<void> showToast(String msg)async {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG, // You can change this to Toast.LENGTH_LONG
    gravity: ToastGravity.BOTTOM, // Position of the toast (e.g., TOP, BOTTOM)
    timeInSecForIosWeb: 1,
  );

}