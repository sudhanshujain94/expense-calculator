import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;
  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _choosedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((_pickedDate) {
      if (_pickedDate == null) {
        return;
      }
      setState(() {
        _choosedDate = _pickedDate;
      });
    });
  }

  void _addTransaction() {
    if (_amountInput.text.isEmpty) {
      return;
    }
    final _enteredtitle = _titleInput.text;
    final _enteredamount = double.parse(_amountInput.text);
    if (_enteredtitle.isEmpty || _enteredamount < 0 || _choosedDate == null) {
      return;
    }
    widget._addNewTransaction(_enteredtitle, _enteredamount, _choosedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: _titleInput,
                onSubmitted: (_) => _addTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
                controller: _amountInput,
                onSubmitted: (_) => _addTransaction(),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _choosedDate == null
                          ? "No Date Choosen"
                          : 'choosed Date : ${DateFormat.yMMMd().format(_choosedDate)}',
                    ),
                  ),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      "choose Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
              RaisedButton(
                elevation: 5,
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _addTransaction,
                child: Text(
                  "Add Transaction",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
