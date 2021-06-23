import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/common_widgets/show_alert_dialogs.dart';
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

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignout = await showAlertDialogs(
      context,
      title: 'Log out',
      content: 'Are you sure that you want to logout',
      defaultActionText: 'Logout',
      cancelActionText: 'Cancel',
    );
    if (didRequestSignout == true) {
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          ElevatedButton(
            onPressed: () => _confirmSignOut(context),
            child: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
