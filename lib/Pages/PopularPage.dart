import 'package:flutter/material.dart';

class PopularPage extends StatefulWidget {
  PopularPage({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("인기 탭", textScaleFactor: 5.0,),
    );
  }
}
