import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget adaptativeBar(
  Function startAddNewTransaction,
  BuildContext ctx) {
  return Platform.isIOS ?
    CupertinoNavigationBar(
      middle: Text('Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => startAddNewTransaction(ctx),
            child: Icon(CupertinoIcons.add),
          )
        ],
      ),
    ) : 
    AppBar(
      title: Text(
        'Flutter App'
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => startAddNewTransaction(ctx),
        )
      ],
    );
}