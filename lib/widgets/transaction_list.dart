import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty ?
        LayoutBuilder(
          builder: (ctx, contraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No Transactions',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: contraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          }
        )
        : ListView.builder(
            itemBuilder: (_, index) {
              return TransactionItem(
                key: ValueKey(transactions[index].id),
                tx: transactions[index],
                deleteTx: deleteTx
              );
            },
            itemCount: transactions.length,
        ),
    );
  }
}