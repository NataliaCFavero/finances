import 'package:charts_flutter/flutter.dart';
import 'package:finances/models/chart.dart';
import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/presenter/list_expense_presenter.dart';
import 'package:finances/usecase/list_expense_use_case.dart';
import 'package:finances/view/extensions/color_extension.dart';
import 'package:finances/view/screens/new_expense.dart';
import 'package:flutter/material.dart';

import 'chart_expense.dart';

const _titleAppBar = 'Despesas';
const _btnChart = 'Ver Gráfico';
const _txtLoading = 'Loading';

abstract class ListExpenseView {
  void onLoadExpenseList(List<Expense> expenseList) {}

  void onLoadChart(Map<int, ChartCategory> mapList) {}
}

class ListExpenses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListExpensesState();
  }
}

class ListExpensesState extends State<ListExpenses> implements ListExpenseView {
  ListExpenseUseCaseImpl _useCase;
  ListExpensePresenterImpl _presenter;
  List<Expense> _listExpense;

  ListExpensesState() {
    _presenter = ListExpensePresenterImpl(this);
    _useCase = ListExpenseUseCaseImpl(_presenter);
  }

  @override
  void initState() {
    super.initState();
    _useCase.onLoadExpenseList();
  }

  @override
  void onLoadExpenseList(List<Expense> expenseList) {
    setState(() {
      _listExpense = expenseList;
    });
  }

  @override
  void onLoadChart(Map<int, ChartCategory> mapList) {
    Future<Expense> future = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PieOutsideLabelChart.withSampleData(mapList)));
  }

  @override
  Widget build(BuildContext context) {
    if (_listExpense == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_titleAppBar),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text(_txtLoading),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            goToNewExpense(context);
          },
        ),
      );
    } else {
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
  }

  Widget _buildList(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
            itemCount: _listExpense.length,
            itemBuilder: (context, index) {
              return ItemExpenses(_listExpense[index]);
            }),
      ),
      FlatButton(
        child: Text(_btnChart),
        textColor: Colors.blue,
        onPressed: () {
          goToGenerateChart();
        },
      )
    ]);
  }

  void goToNewExpense(BuildContext context) {
    Future<Expense> future = Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewExpense()));
    future.then((expense) {
      if (expense != null) {
        _listExpense.add(expense);
      }
    });
  }

  void goToGenerateChart() {
    _useCase.groupListExpense(_listExpense);
  }
}

class ItemExpenses extends StatelessWidget {
  final Expense _expense;

  ItemExpenses(this._expense);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on,
            color: HexColor(_expense.category.color)),
        title: Text(_expense.value.toString()),
        subtitle: Text(_expense.category.description),
      ),
    );
  }
}
