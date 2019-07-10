import 'package:flutter/widgets.dart';
import 'package:demo_app_structure/ui/main/embeddedUi/embeddedApp.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmbeddedUI("城市选择");
  }
}
