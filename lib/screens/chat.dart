import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shape_of_view/shape_of_view.dart';
import 'package:vayuzdemo/constants.dart';
import 'package:vayuzdemo/models/message.dart';
import 'package:vayuzdemo/services/message_service.dart';

class ChatDetails extends StatefulWidget {
  @override
  _ChatDetailsState createState() => _ChatDetailsState();
}

class _ChatDetailsState extends State<ChatDetails> {
  var _message = Message();
  var _messageService = MessageService();

  List<Message> _messageList = List<Message>();

  var message;

  getAllMessages() async {
    Timer(
        Duration(milliseconds: 300),
        () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
    _messageList = List<Message>();
    List<Map<String, dynamic>> messages = await _messageService.readMessages(
        firstnames[currentIndex]);

    messages.forEach((message) {
      setState(() {
        var messageModel = Message();
        messageModel.isMe = message['isMe'];
        messageModel.msg = message['msg'];
        messageModel.time = message['time'];
        messageModel.id = message['id'];
        _messageList.add(messageModel);
      });
    });
  }

  TextEditingController textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool isVisible = true;

  @override
  void initState() {
    getAllMessages();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible)
          setState(() {
            isVisible = false;
          });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible)
          setState(() {
            isVisible = true;
          });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: isVisible ? 63.0 : 0.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 15, left: 5, bottom: 3),
                      child: Text(
                        'Conversation with',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Color(0xFFFFFFFF)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5, bottom: 10),
                      child: Text(
                        '${usernames.elementAt(currentIndex)}',
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFFFFFFFF)),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _messageList.length,
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 6, bottom: 6),
                      child: Bubble(
                        message: _messageList[index].msg,
                        isMe: _messageList[index].isMe,
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF000000),
                ),
                margin: EdgeInsets.only(bottom: 6),
                width: MediaQuery.of(context).size.width * .92,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: textEditingController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 14,
                            color: Color(0xFFFFFFFF)),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14,
                              color: Color(0xFFFFFFFF)),
                          hintText: 'Say something...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        Timer(
                            Duration(milliseconds: 300),
                            () => _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent));
                        _message.isMe = 1;
                        _message.msg = textEditingController.text;
                        _message.time = '${DateTime
                            .now()
                            .hour > 9 ? DateTime
                            .now()
                            .hour : '0''${DateTime
                            .now()
                            .hour}'}:${DateTime
                            .now()
                            .minute > 9 ? DateTime
                            .now()
                            .minute : '0''${DateTime
                            .now()
                            .minute}'}';
                        var result =
                        await _messageService.saveMessage(
                            firstnames[currentIndex], _message);
                        textEditingController.clear();
                        if (result > 0) {
                          print(result);
                          getAllMessages();
                        }
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  final int isMe;
  final String message;

  Bubble({this.message, this.isMe});

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          isMe == 1
              ? Container()
              : CircleAvatar(
                  backgroundImage: AssetImage('assets/images/$currentIndex.jpg'),
                  radius: 22,
                ),
          Container(
            margin: isMe == 1 ? EdgeInsets.only() : EdgeInsets.only(right: 9),
            child: ShapeOfView(
              width: MediaQuery.of(context).size.width * .75,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: BubbleShape(
                  position:
                      isMe == 1 ? BubblePosition.Right : BubblePosition.Left,
                  arrowPositionPercent: 0.5,
                  borderRadius: 5,
                  arrowHeight: 10,
                  arrowWidth: 10),
              child: Container(
                color: isMe == 1 ? Color(0xFF212121) : Color(0xFF384955),
                child: Padding(
                  padding: isMe == 1
                      ? EdgeInsets.only(
                          left: 20, right: 30, top: 10, bottom: 15)
                      : EdgeInsets.only(
                          left: 30, right: 20, top: 15, bottom: 15),
                  child: Text(
                    message,
                    style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 14,
                        color: Color(0xFFFFFFFF)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
