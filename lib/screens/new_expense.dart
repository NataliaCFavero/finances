import 'package:finances/components/input_text.dart';
import 'package:finances/models/expense.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'Nova Despesa';
const _labelValue = 'Valor';
const _hintValue = '00.00';
const _buttonAdd = 'Adicionar';

class NewExpense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewExpenseState();
  }
}

class NewExpenseState extends State<NewExpense> {
  final TextEditingController _controllerExpenseValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: Column(
        children: <Widget>[
          InputText(
            _controllerExpenseValue,
            _labelValue,
            _hintValue,
            icon: Icons.monetization_on,
          ),
          RaisedButton(
            child: Text(_buttonAdd),
            onPressed: () {
              createExpense(context);
            },
          ),
        ],
      ),
    );
  }

  void createExpense(BuildContext context) {
    final double value =
        double.tryParse(_controllerExpenseValue.text.toString());

    if (value != null) {
      Navigator.pop(context, Expense(value, "iFood"));
    }
  }
}
