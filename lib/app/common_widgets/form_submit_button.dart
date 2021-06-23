import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_app/app/common_widgets/custom_text_button.dart';

class FormSubmitButton extends CustomTextButton {
  FormSubmitButton({
    @required String text,
    @required VoidCallback onPressed,
  }) : super(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            height: 44.0,
            color: onPressed != null ? Colors.indigo : Colors.grey,
            borderRadius: 4.0,
            onPressed: onPressed);
}
