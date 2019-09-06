import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdataptativeButton extends StatelessWidget {
  final String text;
  final Function handler;

  const AdataptativeButton({
    Key key,
    @required this.text,
    @required this.handler
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ?
    CupertinoButton(
      onPressed: handler,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      )
    ) :
    FlatButton(
      onPressed: handler,
      textColor: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}