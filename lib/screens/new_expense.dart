import 'package:finances/components/input_text.dart';
import 'package:finances/models/expense.dart';
import 'package:flutter/material.dart';

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
        title: Text('Nova Despesa'),
      ),
      body: Column(
        children: <Widget>[
          InputText(
            _controllerExpenseValue,
            "Valor",
            "00.00",
            icon: Icons.monetization_on,
          ),
          RaisedButton(
            child: Text('Adicionar'),
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

    final Expense expense = Expense(value, "iFood");
    Navigator.pop(context, expense);
  }
}
