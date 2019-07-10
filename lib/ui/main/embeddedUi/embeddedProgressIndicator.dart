import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EmbeddedProgressIndicator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _IOSActivityIndicator();
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      return _AndroidProgressIndicator();
    } else{
      return null;
    }
  }
}

class _AndroidProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}

class _IOSActivityIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator();
  }
}
