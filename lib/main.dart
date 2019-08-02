import 'package:flutter/material.dart';
import 'package:personal_expense/transaction-model.dart';
import 'package:intl/intl.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: 'One', amount: 10.0, date: DateTime.now(), title: 'Shoe'),
    Transaction(id: 'Two', amount: 10.0, date: DateTime.now(), title: 'Bag'),
  ];

  final titleEditingController = TextEditingController();
  final amountEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Card(
            child: Text('sdasd'),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleEditingController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountEditingController,
                  ),
                  FlatButton(
                    child: Text(
                      'Add Transaction',
                      style: TextStyle(color: Colors.purple),
                    ),
                    onPressed: () {
                      print(titleEditingController.text);
                    },
                  )
                ],
              ),
            ),
          ),
          Column(
            children: transactions.map((transaction) {
              return Card(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${transaction.amount}',
                        style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.purple, width: 2.0),
                      ),
                      padding: EdgeInsets.all(5.0),
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transaction.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(transaction.date),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
