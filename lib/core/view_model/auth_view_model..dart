import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {

  final String _clientId = "86wpvkt6w9p2vc";
  final String redirectUrI =
      "https://sites.google.com/view/linkedinloginsuccess/home";
  final String _clientSecret = "rZw4y2pDGyQRTUd6";
  String get url =>
      "https://www.linkedin.com/oauth/v2/authorization?response_type=code&client_id=$_clientId&redirect_uri=$redirectUrI&state=myappauth&scope=r_liteprofile%20r_emailaddress";

  Future<void> getCodeFromUrl(String url) async {
    ///it get code from url
    String code = url.split("code=").last.split("&state").first;
    await getToken(code);
  }

  ///it gets token by using code, [_clientId], [_clientSecret], [redirectUrI]
  Future<void> getToken(String code) async {
    var response = await http.post(
      'https://www.linkedin.com/oauth/v2/accessToken?grant_type=authorization_code&code=$code&redirect_uri=$redirectUrI&client_id=$_clientId&client_secret=$_clientSecret',
    );
    if (response.statusCode == 200) {
      String token = jsonDecode(response.body)["access_token"];
      SharedPreferences.getInstance()
          .then((value) => value.setString("token", token));
    }
  }
}
