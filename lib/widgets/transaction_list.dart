import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ?
        Column(
          children: <Widget>[
            Text(
              'No Transactions',
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 200,
              child: Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ) 
        : ListView.builder(
            itemBuilder: (_, index) {
              final Transaction tx = transactions[index];
              return Card(
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5
                  ),
                  elevation: 5,
                  child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      child: FittedBox(
                        child: Text('\$${tx.amount}'),
                      ),
                      padding: EdgeInsets.all(6),
                    ),
                  ),
                  title: Text(
                    tx.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(tx.date)
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => deleteTx(tx.id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
        ),
    );
  }
}