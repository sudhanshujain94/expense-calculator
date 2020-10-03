import 'package:flutter/material.dart';
import '../model/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function txid;
  TransactionList(this.transaction, this.txid);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (context, constrains) {
              return Column(
                children: [
                  SizedBox(
                    height: constrains.maxHeight * .1,
                  ),
                  Container(
                    height: constrains.maxHeight * .1,
                    child: Text(
                      "No Transactions Yet",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/eagle.png',
                      fit: BoxFit.cover,
                    ),
                    height: constrains.maxHeight * 0.5,
                  )
                ],
              );
            },
          )
        : ListView(
            children: transaction.map((e) {
              return TransactionItem(
                key: ValueKey(e.id),
                transaction: e,
                txid: txid,
              );
            }).toList(),
          );
  }
}
