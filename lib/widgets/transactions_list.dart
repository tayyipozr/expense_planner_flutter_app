import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              Text(
                "No transactions added yet!",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
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
            itemBuilder: (ctx, idx) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text('\$${transactions[idx].amount}')),
                    ),
                  ),
                  title: Text(
                    transactions[idx].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[idx].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 500 ? FlatButton.icon(textColor: Theme.of(context).errorColor, onPressed: () => deleteTx(transactions[idx].id), icon: Icon(Icons.delete), label: Text('Delete')) :IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () => deleteTx(transactions[idx].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length);
  }
}
