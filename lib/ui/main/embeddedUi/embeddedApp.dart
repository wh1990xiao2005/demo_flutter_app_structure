import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo_app_structure/ui/main/embeddedUi/embeddedScafold.dart';

class EmbeddedUI extends StatelessWidget {
  EmbeddedUI(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: EmbeddedScaffold(title),
      );
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoApp(
        title: title,
        home: EmbeddedScaffold(title),
      );
    } else {
      return Center(child: Text("该操作系统暂不支持"));
    }
  }


}
