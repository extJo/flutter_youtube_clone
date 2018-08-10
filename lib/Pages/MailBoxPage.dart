import 'package:flutter/material.dart';

class MailBoxPage extends StatefulWidget {
  MailBoxPage({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() => _MailBoxPageState();
}

class _MailBoxPageState extends State<MailBoxPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("수신함 탭", textScaleFactor: 5.0,),
    );
  }
}
