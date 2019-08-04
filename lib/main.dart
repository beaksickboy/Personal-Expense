import 'package:flutter/material.dart';
import 'package:personal_expense/transaction-model.dart';
import 'package:personal_expense/widget/transaction/transaction-form.dart';
import 'package:personal_expense/widget/transaction/transaction-list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
          onTap: () {},
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showTransactionForm(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: Text('sdasd'),
            ),
            TransactionList(
              transactions: _transactions,
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
