import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.tx,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction tx;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {

  Color _bgColor;

  @override
  void initState() {

    const List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.blueGrey,
      Colors.deepPurple,
      Colors.purple
    ];

    _bgColor = colors[Random().nextInt(colors.length)];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5
        ),
        elevation: 5,
        child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            child: FittedBox(
              child: Text('\$${widget.tx.amount}'),
            ),
            padding: EdgeInsets.all(6),
          ),
        ),
        title: Text(
          widget.tx.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.tx.date)
        ),
        trailing: MediaQuery.of(context).size.height > 500  ?
        FlatButton.icon(
          onPressed: () => widget.deleteTx(widget.tx.id),
          icon: Icon(
            Icons.delete,
          ),
          textColor: Theme.of(context).errorColor,
          label: Text('Delete'),
        )
        :
        
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => widget.deleteTx(widget.tx.id),
        ),
      ),
    );
  }
}