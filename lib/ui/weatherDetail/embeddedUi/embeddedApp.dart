import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo_app_structure/ui/weatherDetail/embeddedUi/embeddedScafold.dart';

class EmbeddedUI extends StatelessWidget {
  EmbeddedUI(this.title,this.cityCode);

  final String title;
  final String cityCode;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: EmbeddedScaffold(title,cityCode),
      );
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoApp(
        title: title,
        home: EmbeddedScaffold(title,cityCode),
      );
    } else {
      return Center(child: Text("该操作系统暂不支持"));
    }
  }


}
