import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vayuzdemo/constants.dart';
import 'package:vayuzdemo/screens/chat.dart';
import 'package:vayuzdemo/screens/chatroom.dart';
import 'package:vayuzdemo/services/message_service.dart';

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
  var _messageService = MessageService();

  initialUpdateLastTextAndTime() async {
    setState(() {
      loading = true;
    });
    await _messageService.initialLastShow();
    setState(() {
      loading = false;
    });
    print('loool$last');
  }

  @override
  void initState() {
    initialUpdateLastTextAndTime();
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
        body: loading
            ? Center(
          child: Container(
              height: 20, width: 20, child: CircularProgressIndicator()),
        )
            : PageView(
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
