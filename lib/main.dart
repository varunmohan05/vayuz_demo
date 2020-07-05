import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vayuzdemo/screens/chat.dart';
import 'package:vayuzdemo/screens/chatroom.dart';

PageController myPage;
var selectedPage;

void main()
{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).
  then((val){
    return runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: App());
  }
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    myPage = PageController(initialPage: 0);
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFF303030),
        appBar: AppBar(
          elevation: 15,
          backgroundColor: Color(0xFF303030),
          title: Text(
            'NETWORK',
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Color(0xFFFFFFFF)),
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              if (selectedPage != 0) {
                myPage.jumpToPage(0);
                setState(() {
                  selectedPage = 0;
                });
              }
            },
          ),
          actions: <Widget>[Icon(Icons.more_vert)],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF212121),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.category, color: Color(0xFFFFFFFF)),
              title: Text(
                'Network',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: Color(0xFFFFFFFF)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: <Widget>[
                  Icon(Icons.message, color: Color(0xFFFFFFFF)),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: new Icon(Icons.brightness_1,
                        size: 10.0, color: Color(0xFF00AEEF)),
                  ),
                ],
              ),
              title: Text(
                'Messages',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: Color(0xFFFFFFFF)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_calendar, color: Color(0xFFFFFFFF)),
              title: Text(
                'Contact',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: Color(0xFFFFFFFF)),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library, color: Color(0xFFFFFFFF)),
              title: Text(
                'Library',
                style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w200,
                    fontSize: 12,
                    color: Color(0xFFFFFFFF)),
              ),
            ),
          ],
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: myPage,
          children: <Widget>[
            Chats(),
            ChatDetails(),
          ],
        ),
      ),
    );
  }
}
