import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/app/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_app/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker_app/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_app/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_app/services/auth.dart';

class SignInPage extends StatelessWidget {
  static Widget create(BuildContext context) {
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(),
      child: SignInPage(),
    );
  }
  void _showSignInError(
    BuildContext context,
    Exception exception,
  ) {
    if (exception is FirebaseException &&
        exception.code == "ERROR_ABORTED_BY_USER") {
      return;
    }
    showExceptionAlertDialog(
      context,
      title: 'Sign in failed',
      exception: exception,
    );
  }

  Future<void> _signInwithAnomonymous(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymous();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInwithGoogle(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  Future<void> _signInwithFacebook(BuildContext context) async {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignInBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: StreamBuilder<bool>(
          initialData: false,
          stream: bloc.isLoadingStream,
          builder: (context, snapshot) {
            return _buildContent(context, snapshot.data);
          }),
      backgroundColor: Colors.grey[300],
    );
  }

  Widget _buildContent(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 58.0,
            child: _buildHeader(isLoading),
          ),
          SizedBox(height: 48.0),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in with Goolge',
            color: Colors.white,
            textColor: Colors.black,
            onPressed: isLoading ? null : () => _signInwithGoogle(context),
          ),
          SizedBox(height: 8.0),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInwithFacebook(context),
            // onPresssed: () {},
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Sign in with Email',
            color: Colors.teal[700],
            textColor: Colors.white,
            onPresssed: isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(height: 8.0),
          Text(
            'or',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.0),
          SignInButton(
            text: 'Go anonymous',
            color: Colors.lime[300],
            textColor: Colors.black,
            onPresssed: () => _signInwithAnomonymous(context),
          ),
          // Image.asset('images/google-logo.png')
        ],
      ),
    );
  }

  Widget _buildHeader(bool isLoading) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
