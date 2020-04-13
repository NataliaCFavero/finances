import 'package:finances/models/expense.dart';
import 'package:finances/screens/new_expense.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'Despesas';

class ListExpenses extends StatefulWidget {
  final List<Expense> _listExpense = List();

  @override
  State<StatefulWidget> createState() {
    return ListExpensesState();
  }
}

class ListExpensesState extends State<ListExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: ListView.builder(
          itemCount: widget._listExpense.length,
          itemBuilder: (context, index) {
            return ItemExpenses(widget._listExpense[index]);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Future<Expense> future = Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewExpense()));
          future.then((expense) {
            if (expense != null) {
              widget._listExpense.add(expense);
            }
          });
        },
      ),
    );
  }
}

class ItemExpenses extends StatelessWidget {
  final Expense _expense;

  ItemExpenses(this._expense);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_expense.value.toString()),
        subtitle: Chip(
          backgroundColor: Colors.amber,
          label: Text(_expense.category),
        ),
      ),
    );
  }
}
