import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:demo_app_structure/entity/cityList.dart';
import 'package:demo_app_structure/ui/weatherDetail/weatherDetail.dart';

class EmbeddedListView extends StatefulWidget {
  EmbeddedListView(this.cityList);

  final CityList cityList;

  @override
  State<StatefulWidget> createState() {
    return _EmbeddedListViewState();
  }
}

class _EmbeddedListViewState extends State<EmbeddedListView> {
  void jumpToDetail(String cityCode) {
    Navigator.push<int>(
        context,
        new CupertinoPageRoute(
            builder: (BuildContext context) => WeatherDetail(cityCode)));
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return buildAndroidListView();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      return buildIOSListView();
    } else {
      return null;
    }
  }

  Widget buildAndroidListView() {
    return ListView.separated(
        separatorBuilder: (context, index) =>
            Container(color: Colors.black, height: 0.3),
        itemCount: widget.cityList.cityListItems.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              alignment: Alignment.center,
              child: Text(widget.cityList.cityListItems[index].city_name),
              width: double.infinity,
              height: 50.0,
            ),
            onTap: () {
              if (widget.cityList.cityListItems[index].city_code != "") {
                jumpToDetail(widget.cityList.cityListItems[index].city_code);
              }
            },
          );
        });
  }

  Widget buildIOSListView() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, index) =>
            Container(color: CupertinoColors.inactiveGray, height: 0.3),
        itemCount: widget.cityList.cityListItems.length,
        itemBuilder: (context, index) {
          return CupertinoButton(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 20.0,
                child: Text(widget.cityList.cityListItems[index].city_name),
              ),
              onPressed: () {
                if (widget.cityList.cityListItems[index].city_code != "") {
                  jumpToDetail(widget.cityList.cityListItems[index].city_code);
                }
              });
        });
  }
}
