import 'package:flutter/material.dart';

class SubscribePage extends StatefulWidget {
  SubscribePage({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("구독 탭", textScaleFactor: 5.0,),
    );
  }
}
