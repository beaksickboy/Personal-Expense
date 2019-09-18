import 'package:flutter/material.dart';

import 'package:personal_expense/transaction-model.dart';
import 'package:personal_expense/widget/transaction/chart.dart';
import 'package:personal_expense/widget/transaction/transaction-form.dart';
import 'package:personal_expense/widget/transaction/transaction-list.dart';

void main() async {
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

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expense'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => showTransactionForm(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(_recentTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height - MediaQuery.of(context).padding.top) *
                  0.6,
              child: TransactionList(
                transactions: _transactions,
              ),
            )
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
