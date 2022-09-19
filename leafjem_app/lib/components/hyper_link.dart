import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class HyperLink extends StatelessWidget {
  final String displayText;
  final String path;

  const HyperLink({
    Key? key,
    required this.displayText,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: displayText,
          style: const TextStyle(
              color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w500),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launchUrl(Uri.https('pixsoil.vercel.app', path));
            }),
    );
  }
}
