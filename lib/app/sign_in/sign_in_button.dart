import 'package:flutter/cupertino.dart';
import 'package:time_tracker_app/app/common_widgets/custom_text_button.dart';

class SignInButton extends CustomTextButton {
  SignInButton({
    @required String text,
    Color color,
    Color textColor,
    VoidCallback onPresssed,
  })  : assert(text != null),
        super(
            child: Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15),
            ),
            color: color,
            onPressed: onPresssed);
}
