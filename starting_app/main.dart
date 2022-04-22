import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  print("hey");
  final value = await printThere();

  print(value);
}

Future<String> printThere() async {
  final pref = await SharedPreferences.getInstance();

  await Future.delayed(Duration(seconds: 2));
  final myString = await Future.value("2.0");
  return myString;
}
