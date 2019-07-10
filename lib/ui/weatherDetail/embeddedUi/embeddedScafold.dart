import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo_app_structure/entity/WeatherResp.dart';
import 'package:demo_app_structure/util/httpRequest.dart';
import 'package:demo_app_structure/util/jsonParser.dart';

WeatherData weatherData;

class EmbeddedScaffold extends StatefulWidget {
  EmbeddedScaffold(this.title, this.cityCode);

  final String title;
  final String cityCode;

  @override
  State<StatefulWidget> createState() {
    return _EmbeddedScaffoldState(cityCode);
  }
}

class _EmbeddedScaffoldState extends State<EmbeddedScaffold> {
  String cityCode;
  bool isLoading = false;

  _EmbeddedScaffoldState(this.cityCode);

  void refreshData() {
    if (!isLoading) {
      isLoading = true;
      HttpRequest("http://t.weather.sojson.com/api/weather/city/$cityCode")
          .httpRequest()
          .then((data) {
        setState(() {
          weatherData = WeatherData.fromJson(JsonParser(data).parseFromJson());
          isLoading = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _IOSScaffold(widget.title);
    } else if (Theme.of(context).platform == TargetPlatform.android) {
      return _AndroidScaffold(widget.title);
    } else {
      return null;
    }
  }
}

class _AndroidScaffold extends StatefulWidget {
  _AndroidScaffold(this.title);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _AndroidScaffoldState();
  }
}

class _AndroidScaffoldState extends State<_AndroidScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: buildAndroidWeatherDetail());
  }
}

class _IOSScaffold extends StatefulWidget {
  _IOSScaffold(this.title);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _IOSScaffoldState();
  }
}

class _IOSScaffoldState extends State<_IOSScaffold> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.title),
          automaticallyImplyLeading: true,
          previousPageTitle: "城市选择",
        ),
        child: buildIOSWeatherDetail());
  }
}

Widget buildAndroidWeatherDetail() {
  return ListView(
    children: <Widget>[
      Text(weatherData == null ? "" : "【基本信息】",
          style: new TextStyle(color: Colors.blue)),
      weatherData == null ? Text("") : buildBaseInfo(weatherData),
      Text(weatherData == null ? "" : "【当前天气】",
          style: new TextStyle(color: Colors.blue)),
      weatherData == null ? Text("") : buildCurrent(weatherData),
      Text(weatherData == null ? "" : "【昨日天气】",
          style: new TextStyle(color: Colors.blue)),
      weatherData == null ? Text("") : buildYesterday(weatherData),
      Text(weatherData == null ? "" : "【未来预报】",
          style: new TextStyle(color: Colors.blue)),
      weatherData == null ? Text("") : buildForecast(weatherData),
    ],
  );
}

Widget buildIOSWeatherDetail() {
  return ListView(
    physics: BouncingScrollPhysics(),
    children: <Widget>[
      Text(weatherData == null ? "" : "【基本信息】",
          style: new TextStyle(color: CupertinoColors.activeGreen)),
      weatherData == null ? Text("") : buildBaseInfo(weatherData),
      Text(weatherData == null ? "" : "【当前天气】",
          style: new TextStyle(color: CupertinoColors.activeGreen)),
      weatherData == null ? Text("") : buildCurrent(weatherData),
      Text(weatherData == null ? "" : "【昨日天气】",
          style: new TextStyle(color: CupertinoColors.activeGreen)),
      weatherData == null ? Text("") : buildYesterday(weatherData),
      Text(weatherData == null ? "" : "【未来预报】",
          style: new TextStyle(color: CupertinoColors.activeGreen)),
      weatherData == null ? Text("") : buildForecast(weatherData),
    ],
  );
}

Column buildBaseInfo(weatherData) {
  List<Widget> widgets = new List();
  widgets.add(Text("获取时间：${weatherData.time}"));
  widgets.add(Text("省：${weatherData.cityInfo.parent}"));
  widgets.add(Text("市：${weatherData.cityInfo.city}"));
  widgets.add(Text("更新时间：${weatherData.cityInfo.updateTime}"));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
}

Column buildCurrent(weatherData) {
  List<Widget> widgets = new List();
  widgets.add(Text("湿度：${weatherData.data.shidu}"));
  widgets.add(Text("PM2.5：${weatherData.data.pm25}"));
  widgets.add(Text("PM10：${weatherData.data.pm10}"));
  widgets.add(Text("空气质量：${weatherData.data.quality}"));
  widgets.add(Text("气温：${weatherData.data.wendu}"));
  widgets.add(Text("感冒指数：${weatherData.data.ganmao}"));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
}

Column buildYesterday(weatherData) {
  List<Widget> widgets = new List();
  widgets.add(Text("昨日日出：${weatherData.data.yesterday.sunrise}"));
  widgets.add(Text("昨日日落：${weatherData.data.yesterday.sunset}"));
  widgets.add(Text("昨日最高温：${weatherData.data.yesterday.high}"));
  widgets.add(Text("昨日最低温：${weatherData.data.yesterday.low}"));
  widgets.add(Text("昨日风向：${weatherData.data.yesterday.fx}"));
  widgets.add(Text("昨日风力：${weatherData.data.yesterday.fl}"));
  widgets.add(Text("昨日天气：${weatherData.data.yesterday.type}"));
  widgets.add(Text("昨日提醒：${weatherData.data.yesterday.notice}"));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
}

Column buildForecast(weatherData) {
  List<Widget> widgets = new List();
  for (var i = 0; i < weatherData.data.foreCast.foreCastItems.length; i++) {
    widgets.add(Text("日期：${weatherData.data.foreCast.foreCastItems[i].date}"));
    widgets
        .add(Text("日出：${weatherData.data.foreCast.foreCastItems[i].sunrise}"));
    widgets
        .add(Text("日落：${weatherData.data.foreCast.foreCastItems[i].sunset}"));
    widgets.add(Text("最高温：${weatherData.data.foreCast.foreCastItems[i].high}"));
    widgets.add(Text("最低温：${weatherData.data.foreCast.foreCastItems[i].low}"));
    widgets.add(Text("风向：${weatherData.data.foreCast.foreCastItems[i].fx}"));
    widgets.add(Text("风力：${weatherData.data.foreCast.foreCastItems[i].fl}"));
    widgets.add(Text("天气：${weatherData.data.foreCast.foreCastItems[i].type}"));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: widgets,
  );
}
