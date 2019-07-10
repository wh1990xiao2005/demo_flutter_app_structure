import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'embeddedProgressIndicator.dart';
import 'embeddedListView.dart';
import 'package:demo_app_structure/entity/cityList.dart';
import 'package:demo_app_structure/util/jsonParser.dart';
import 'package:demo_app_structure/util/fileReader.dart';

CityList cityList;

class EmbeddedScaffold extends StatefulWidget {
  EmbeddedScaffold(this.title);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _EmbeddedScaffoldState();
  }
}

class _EmbeddedScaffoldState extends State<EmbeddedScaffold> {

  void loadCityListData() {
    FileReader(context).assetFileReader("assets/citylist.json").then((data) {
      setState(() {
        cityList = CityList.fromJson(JsonParser(data).parseFromJson());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadCityListData();
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
      body: Center(
          child: cityList == null
              ? EmbeddedProgressIndicator()
              : buildCityListView()),
    );
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
            middle: Text(widget.title), automaticallyImplyLeading: true),
        child: Center(
            child: cityList == null
                ? EmbeddedProgressIndicator()
                : buildCityListView()));
  }
}

Widget buildCityListView() {
  return EmbeddedListView(cityList);
}
