import 'package:flutter/material.dart';
import 'package:youtube_flutter_clone/Pages/HomePage.dart';
import 'package:youtube_flutter_clone/Pages/PopularPage.dart';
import 'package:youtube_flutter_clone/Pages/SubscribePage.dart';
import 'package:youtube_flutter_clone/Pages/MailBoxPage.dart';
import 'package:youtube_flutter_clone/Pages/LibraryPage.dart';
import 'package:youtube_flutter_clone/Assets/Color.dart';

void main() {
  runApp(MyTube());
}

class MyTube extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new MaterialApp(
    title: 'YouTube',
    home: new BaseApp(),
  );
}

class BaseApp extends StatefulWidget {
  BaseApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  var index = 0;
  final List<Widget> _children = [
    new HomePage(),
    new PopularPage(),
    new SubscribePage(),
    new MailBoxPage(),
    new LibraryPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _buildBaseApp(context);

  /// create [Scaffold].
  /// Implements the basic material design visual layout structure.
  Widget _buildBaseApp(context) => new Scaffold(
    appBar: _buildMatchAppBar(context),
    bottomNavigationBar: _buildBottomNavigationBar(context),
    body: _children[index],
    backgroundColor: AppBackgroundColor,
//    floatingActionButton: FloatingActionButton(
//      onPressed: () => showDialog(
//        context: context,
//        builder: (BuildContext) => new Center(
//          child: Center(
//            child: Text(
//              "Button Clicked!",
//              style: TextStyle(color: Colors.white, decoration: TextDecoration.none, fontSize: 20.0),
//            )
//          )
//        )
//      ),
//    ),
  );

  /// return AppBar according to the selected index of the tab.
  Widget _buildMatchAppBar(context) {
    return AppBar(
      title: Row(
        children: <Widget>[
          new Icon(Icons.airplay, color: AppBarColor, size: 30.0),
          new Container(
            child: Text('MyTube', style: TextStyle(color: AppBarColor, fontWeight: FontWeight.bold)),
            padding: const EdgeInsets.only(left: 10.0),
          ),
        ],
      ),
      centerTitle: false,
      backgroundColor: AppBackgroundColor,
    );
  }

  /// return bottom navigation bar
  Widget _buildBottomNavigationBar(context) => new Theme(
      data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
          canvasColor: AppBackgroundColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: BottomNaviItemSelectedColor,
          iconTheme: Theme
              .of(context)
              .iconTheme
              .copyWith(color: BottomNaviItemColor),
          textTheme: Theme
              .of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: BottomNaviItemColor))), // sets the inactive color of the `BottomNavigationBar`
      child: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem('홈', Icons.home),
          _buildBottomNavigationBarItem('인기', Icons.poll),
          _buildBottomNavigationBarItem('구독', Icons.subscriptions),
          _buildBottomNavigationBarItem('수신함', Icons.mail),
          _buildBottomNavigationBarItem('라이브러리', Icons.format_list_bulleted),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (int i) {setState(() => index = i);},
      )
  );

  /// return bottom navigation bar item
  BottomNavigationBarItem _buildBottomNavigationBarItem(title, icon) => new BottomNavigationBarItem(
    icon: Icon(icon,),
    title: Text(title, style: TextStyle(fontSize: 10.0,)),
  );
}