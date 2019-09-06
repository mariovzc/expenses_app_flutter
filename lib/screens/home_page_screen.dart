import 'dart:io';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/adaptative_bar.dart';
import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';
import 'package:expenses/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  final List<Transaction> _userTransactions = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7)
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }
  
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      }, );
  }

  List<Widget> _buildLandspaceContent(
    bool _showCart,
    Widget chartWidget,
    Widget txListWidget
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            onChanged: (value) {
              setState(() => _showChart = value);
            } ,
            value: _showChart,
          )
        ],
      ),
      _showChart ? 
        chartWidget :
        txListWidget
    ];
  }
  
  List<Widget> _buildPortraitContent(
    Widget chartWidget,
    Widget txListWidget
  ) {
    return [
      chartWidget,
      txListWidget,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == 
                        Orientation.landscape;
    final PreferredSizeWidget appBar = adaptativeBar(
      _startAddNewTransaction,
      context
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
              0.7,
      child: TransactionList(
        _userTransactions,
        _deleteTransaction
      ),
    );

    Widget _chartWidget(double heightPercent) => Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
              heightPercent,
      child: Chart(_recentTransactions)
    );

    final screenBody = SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(isLandscape) 
              ..._buildLandspaceContent(
                _showChart,
                _chartWidget(0.7),
                txListWidget
              ),
            if(!isLandscape)
              ..._buildPortraitContent(
                _chartWidget(0.3),
                txListWidget
              ),
          ],
        ),
      );

    return Platform.isIOS ?
    CupertinoPageScaffold(
      child: SafeArea(
        child: screenBody,
      ),
      navigationBar: appBar,
    ) : 
    Scaffold(
      appBar: appBar,
      body: screenBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ?
      null :
      FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}