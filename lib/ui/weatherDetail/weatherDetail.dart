import 'package:demo_app_structure/ui/weatherDetail/embeddedUi/embeddedApp.dart';
import 'package:flutter/widgets.dart';

class WeatherDetail extends StatelessWidget {
  WeatherDetail(this.cityCode);

  final String cityCode;

  @override
  Widget build(BuildContext context) {
    return EmbeddedUI("天气详情", cityCode);
  }
}
