import 'package:flutter/material.dart';
import 'package:time_tracker_app/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  const HomePage({@required this.auth});
  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          ElevatedButton(
            onPressed: _signOut,
            child: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
