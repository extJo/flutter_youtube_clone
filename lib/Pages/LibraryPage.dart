import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  LibraryPage({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("인기 탭", textScaleFactor: 5.0,),
    );
  }
}
