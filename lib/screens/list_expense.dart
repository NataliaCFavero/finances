import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/screens/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'chart_expense.dart';

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
      body: _buildList(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          goToNewExpense(context);
        },
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
            itemCount: widget._listExpense.length,
            itemBuilder: (context, index) {
              return ItemExpenses(widget._listExpense[index]);
            }),
      ),
      FlatButton(
        child: Text("Ver Gráfico"),
        textColor: Colors.blue,
        onPressed: () {
          goToGenerateChart(context);
        },
      )
    ]);
  }

  void goToNewExpense(BuildContext context) {
    Future<Expense> future = Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewExpense()));
    future.then((expense) {
      if (expense != null) {
        widget._listExpense.add(expense);
      }
    });
  }

  void goToGenerateChart(BuildContext context) {
    Map<int, Chart> chart = groupListExpense(widget._listExpense);
    Future<Expense> future = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PieOutsideLabelChart.withSampleData(chart)));
    future.then((expense) {
      if (expense != null) {
        widget._listExpense.add(expense);
      }
    });
  }

  Map<int, Chart> groupListExpense(List<Expense> listExpense) {
    Chart chartCategory;

    Map<int, Chart> mapList = Map<int, Chart>();

    for (Expense expense in listExpense) {
      List<Expense> list = listExpense
          .where((f) => f.category.index == expense.category.index)
          .toList();

      double total = 0;
      list.forEach((f) => total += f.value);

      chartCategory = Chart(total, expense.category);
      mapList.putIfAbsent(expense.category.index, () => chartCategory);
    }

    mapList.forEach((f, v) => print(v.total));
    return mapList;
  }
}

class Chart {
  double total;
  ExpenseType description;

  Chart(this.total, this.description);
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
        subtitle: Text(_expense.category.description),
      ),
    );
  }
}
