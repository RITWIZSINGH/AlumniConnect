import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class SocialSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const SocialSignInButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.google,
      onPressed: onPressed,
      text: text,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}