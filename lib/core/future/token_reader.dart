import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tokenReader = FutureProvider<String>((ref) async {
  SharedPreferences _preferences = await SharedPreferences.getInstance();

  ///if user not logined, token will be null
  String token = _preferences.getString("token");
  print(token);
  return token;
});
