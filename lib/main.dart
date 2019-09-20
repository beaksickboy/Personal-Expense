import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:personal_expense/transaction-model.dart';
import 'package:personal_expense/widget/transaction/chart.dart';
import 'package:personal_expense/widget/transaction/transaction-form.dart';
import 'package:personal_expense/widget/transaction/transaction-list.dart';

void main() async {
  // Restricte orientation
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Pacifico',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Pacifico',
                ),
              ),
        ),
      ),
      // home: MyHomePage(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TransactionModel> _transactions = [
    TransactionModel(
        id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
    TransactionModel(
        id: 'Two', amount: 10.0, date: DateTime.now(), title: 'Bag'),
    TransactionModel(
        id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
    TransactionModel(
        id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
    TransactionModel(
        id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
    TransactionModel(
        id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
    TransactionModel(
        id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
    TransactionModel(
        id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
    TransactionModel(
        id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
  ];

  bool _showChart = false;

  void _addTransaction(String title, double amount) {
    final transaction = TransactionModel(
        amount: amount, title: title, id: 'what', date: DateTime.now());
    setState(() {
      _transactions.add(transaction);
    });
  }

  void showTransactionForm(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GestureDetector(
          child: TransactionForm(_addTransaction),
          onTap: () {}, // Not close modal when tap on
          behavior: HitTestBehavior.opaque, // Not close modal when tap on
        );
      },
    );
  }

  List<TransactionModel> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  createSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show chart'),
        Switch(
          value: _showChart,
          onChanged: (value) {
            setState(() {
              _showChart = value;
            });
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check orientation
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    
    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => showTransactionForm(context),
        )
      ],
    );

    final transactionListWidget = (heightPercent) {
      return Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) * // padding.top is system ui navbar
            heightPercent,
        child: TransactionList(
          transactions: _transactions,
        ),
      );
    };

    final barChart = (heightPercent) {
      return Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            heightPercent,
        child: Chart(_recentTransactions),
      );
    };

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // Change Widget base on Orientation
          children: <Widget>[
            if (!isLandscape) barChart(0.3),
            if (!isLandscape) transactionListWidget(0.6),
            if (isLandscape) createSwitch(),
            if (isLandscape)
              _showChart ? barChart(0.7) : transactionListWidget(0.7),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showTransactionForm(context),
      ),
    );
  }
}
