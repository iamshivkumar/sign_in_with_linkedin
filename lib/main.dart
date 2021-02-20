import 'package:flutter/material.dart';
import 'package:linkedin_auth/core/future/token_reader.dart';
import 'package:linkedin_auth/ui/home_page.dart';
import 'package:linkedin_auth/ui/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    /// it gets Async value of token from [SharedPreferences] using FutureProvider as [tokenFuture]
    var tokenFuture = watch(tokenReader);
    return MaterialApp(
      title: 'My Linkedin',
      theme: ThemeData(
        primaryColor: Color(0xFF00669A),
        accentColor: Color(0xFF00669A),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: tokenFuture.when(
        data: (token) => token == null ? LoginPage() : HomePage(),
        loading: () => Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (error, stackTrace) => Container(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
