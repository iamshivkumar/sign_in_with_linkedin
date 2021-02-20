import 'package:flutter/material.dart';
import 'package:linkedin_auth/core/future/token_reader.dart';
import 'package:linkedin_auth/core/view_model/auth_view_model_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// it access state from [AuthViewModel] by using [authViewModelProvider] as model
    var model = context.read(authViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in with Linkedin"),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: model.url,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) async {
              ///when login success webpage should navigate to [redirectUrI]. but further code will prevent that.
              if (request.url.startsWith(model.redirectUrI)) {
                ///it gets code from url and then token by using that code. And save to [SharedPreferences] with key "token"
                await model.getCodeFromUrl(request.url);

                ///it refreshes [tokenReader] to re-read token from [SharedPreferences]
                context.refresh(tokenReader);

                Navigator.pop(context);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            gestureNavigationEnabled: true,
          ),
        ],
      ),
    );
  }
}
