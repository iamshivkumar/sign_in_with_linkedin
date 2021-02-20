import 'package:flutter/material.dart';
import 'package:linkedin_auth/core/future/token_reader.dart';
import 'package:linkedin_auth/core/service/auth_view_model..dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebPage extends StatelessWidget {
  final AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in with Linkedin"),
      ),
      body: WebView(
        initialUrl: auth.url,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) async {
          ///when login success webpage should navigate to [redirectUrI]. but further code will prevent that.
          if (request.url.startsWith(auth.redirectUrI)) {
            ///it gets code from url and then token by using that code. And save to [SharedPreferences] with key "token"
            await auth.getCodeFromUrl(request.url);

            ///it refreshes [tokenReader] to re-read token from [SharedPreferences]
            context.refresh(tokenReader);

            Navigator.pop(context);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        gestureNavigationEnabled: true,
      ),
    );
  }
}
