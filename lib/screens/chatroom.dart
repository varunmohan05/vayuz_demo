import 'package:flutter/material.dart';
import 'package:vayuzdemo/constants.dart' as Con;
import 'package:vayuzdemo/main.dart';
import 'package:vayuzdemo/services/message_service.dart';

import 'chat.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  bool loading = false;
  var _messageService = MessageService();
  List<String> last = ['', ''];
  updateLastTextAndTime() async {
    setState(() {
      loading = true;
    });
    last = await _messageService.lastShow();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateLastTextAndTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: Container(
                height: 20, width: 20, child: CircularProgressIndicator()),
          )
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 25, left: 5, bottom: 25),
                    child: Text(
                      'Messages (4)',
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Color(0xFFFFFFFF)),
                    ),
                  ),
                  ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Con.currentIndex = index;
                          myPage.jumpToPage(1);
                          setState(() {
                            selectedPage = 1;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 5, right: 5),
                          padding:
                              EdgeInsets.only(top: 10, bottom: 10, right: 10),
                          child: Row(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/$index.jpg'),
                                      minRadius: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          Con.usernames.elementAt(index),
                                          style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                        Text(
                                          '${last.elementAt(0)}',
                                          style: TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 13,
                                              color: Color(0xFFFFFFFF)),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 5),
                                    ),
                                    Text(
                                      '${last.elementAt(1)}',
                                      style: TextStyle(
                                          fontFamily: 'Lato',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 16,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
  }
}
