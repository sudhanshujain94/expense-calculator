import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.txid,
  }) : super(key: key);

  final Transaction transaction;
  final Function txid;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  final _colorList = [Colors.green, Colors.pink, Colors.red, Colors.amber];

  @override
  void initState() {
    _bgColor = _colorList[Random().nextInt(_colorList.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: _bgColor,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: FittedBox(
              child: Text(
                widget.transaction.amount.toStringAsFixed(2),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width < 400
            ? IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => widget.txid(widget.transaction.id),
                color: Colors.red,
              )
            : FlatButton.icon(
                onPressed: () => widget.txid(widget.transaction.id),
                icon: Icon(Icons.delete),
                label: Text("delete"),
                textColor: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
