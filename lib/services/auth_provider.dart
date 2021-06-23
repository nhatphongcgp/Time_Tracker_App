import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/services/auth.dart';

class AuthProvider extends InheritedWidget {
  final AuthBase auth;
  final Widget child;
  AuthProvider({@required this.auth, @required this.child});
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
  static AuthBase of(BuildContext context) {
    AuthProvider provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider.auth;
  }
}
