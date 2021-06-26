import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/services/auth.dart';

class SignInManager {
  SignInManager({@required this.isLoading, @required this.auth});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;
  // final StreamController<bool> _isLoadingController = StreamController<bool>();
  // Stream<bool> get isLoadingStream => _isLoadingController.stream;
  // void dispose() {
  //   _isLoadingController.close();
  // }
  // void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      // _setIsLoading(true);
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      // _setIsLoading(false);
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
  Future<User> signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
  Future<User> signInAnonymous() async => await _signIn(auth.signInAnonymous);
}
