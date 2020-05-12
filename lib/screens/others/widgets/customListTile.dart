import 'package:flutter/material.dart';
import '../../../utils/size_config.dart';

class CustomListTile extends StatelessWidget {
  String title, value;
  CustomListTile({this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: SizeConfig.getResponsiveWidth(30.0),
          right: SizeConfig.getResponsiveWidth(25.0),
          bottom: SizeConfig.getResponsiveWidth(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(fontSize: SizeConfig.getResponsiveHeight(12.0)),
            ),
          ),
          Container(
            child: Text(
              value,
              style: TextStyle(fontSize: SizeConfig.getResponsiveHeight(12.0)),
            ),
          )
        ],
      ),
    );
  }
}
