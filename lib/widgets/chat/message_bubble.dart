import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final String imageUrl;

  const MessageBubble(
      {Key key,
      @required this.message,
      @required this.isMe,
      @required this.username,
      @required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    isMe ? Colors.grey.shade300 : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft:
                      !isMe ? Radius.circular(0.0) : Radius.circular(12.0),
                  bottomRight:
                      isMe ? Radius.circular(0.0) : Radius.circular(12.0),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.headline6.color,
                      )),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.right : TextAlign.left,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline6
                                .color),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
        ),
      ],
    );
  }
}
