import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import './widget/new_transaction.dart';
import './widget/transaction_list.dart';
import './model/transaction.dart';
import './widget/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monthly Expense',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "JosefinSans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        accentColor: Colors.red,
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: "SourceSansPro",
                    fontSize: 22,
                    color: Colors.white),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with WidgetsBindingObserver {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: "1",
      title: "shirt",
      amount: 19.8,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: "2",
      title: "shoes",
      amount: 45.34,
      date: DateTime.now(),
    ),
  ];
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  var _switchvalue = true;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosedDate) {
    final _newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: choosedDate,
    );
    setState(() {
      _userTransaction.add(_newTx);
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  void _startAddNewTransaction() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _deleteTx(String txid) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == txid);
    });
  }

  List<Widget> _buildLandscapeContent(double _remainingHeight) {
    return [
      Container(
        height: _remainingHeight * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Show Chart"),
            Switch.adaptive(
              inactiveTrackColor: Colors.red[200],
              inactiveThumbColor: Theme.of(context).errorColor,
              activeTrackColor: Theme.of(context).primaryColorLight,
              activeColor: Theme.of(context).primaryColor,
              value: _switchvalue,
              onChanged: (val) => setState(() {
                _switchvalue = val;
              }),
            ),
          ],
        ),
      ),
      _switchvalue
          ? Container(
              height: _remainingHeight * 0.55,
              child: Chart(_recentTransaction),
            )
          : Container(
              height: _remainingHeight * 0.8,
              child: TransactionList(_userTransaction, _deleteTx),
            ),
    ];
  }

  List<Widget> _buildPortrateContent(double _remainingHeight) {
    return [
      Container(
        height: _remainingHeight * 0.28,
        child: Chart(_recentTransaction),
      ),
      Container(
        height: _remainingHeight * 0.72,
        child: TransactionList(_userTransaction, _deleteTx),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _mediaquery = MediaQuery.of(context);
    final PreferredSizeWidget _appBar = AppBar(
      title: Text('Monthly Expense'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: _startAddNewTransaction,
        )
      ],
    );
    final _remainingHeight = (_mediaquery.size.height -
        _appBar.preferredSize.height -
        _mediaquery.padding.top);

    final _isLandscape = _mediaquery.orientation == Orientation.landscape;
    return Scaffold(
      appBar: _appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_isLandscape) ..._buildLandscapeContent(_remainingHeight),
              if (!_isLandscape) ..._buildPortrateContent(_remainingHeight),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _startAddNewTransaction,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
