import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkedin_auth/core/future/token_reader.dart';
import 'package:http/http.dart' as http;
import 'package:linkedin_auth/core/models/linkedin_user.dart';

final userDataProvider = FutureProvider<LinkedinUser>(
  (ref) async {
    ///reading [token] from tokenReader
    var token = ref.read(tokenReader).data.value;

    ///it will authenticate by token and get user Profile Data.
    final response = await http.get(
      'https://api.linkedin.com/v2/me?projection=(id,localizedFirstName,localizedLastName,profilePicture(displayImage~:playableStreams))',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    ///it will authenticate by token and get user email.
    final emailResponse = await http.get(
      'https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))',
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    return LinkedinUser.fromJson(
      jsonDecode(response.body),
      jsonDecode(emailResponse.body),
    );
  },
);
