import 'package:flutter/material.dart';
import 'package:linkedin_auth/ui/web_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebPage(),
                      ),
                    );
                  },
                  child: Image.asset("assets/Sign-In-Large---Hover.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
