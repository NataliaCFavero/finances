import 'package:finances/components/input_text.dart';
import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

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
  final MoneyMaskedTextController _controllerExpenseValue =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  RadioListExpenseTypeWidget statefulWidget = RadioListExpenseTypeWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InputText(
              _controllerExpenseValue,
              _labelValue,
              _hintValue,
              icon: Icons.monetization_on,
            ),
            statefulWidget,
            RaisedButton(
              child: Text(_buttonAdd),
              onPressed: () {
                createExpense(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void createExpense(BuildContext context) {
    if (statefulWidget._character != null) {
      Navigator.pop(
          context,
          Expense(_controllerExpenseValue.numberValue,
              statefulWidget._character.description));
    } else {
      _neverSatisfied();
    }
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Classificar Despesa'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Selecione o tipo da sua despesa.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

enum SingingCharacter { lafayette, jefferson }

class RadioListExpenseTypeWidget extends StatefulWidget {
  RadioListExpenseTypeWidget({Key key}) : super(key: key);

  List<ExpenseType> expenseTypeList = ExpenseType().newList();
  List<Widget> widgetsList = [];
  ExpenseType _character;

  @override
  _RadioListExpenseTypeWidgetState createState() =>
      _RadioListExpenseTypeWidgetState();
}

class _RadioListExpenseTypeWidgetState
    extends State<RadioListExpenseTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: createList(),
    );
  }

  List<RadioListTile> createList() {
    List<RadioListTile> listTile = [];
    for (ExpenseType type in widget.expenseTypeList) {
      listTile.add(createRadioList(type));
    }
    return listTile;
  }

  RadioListTile createRadioList(ExpenseType expenseType) {
    return RadioListTile<ExpenseType>(
      title: Text(expenseType.description),
      value: expenseType,
      groupValue: widget._character,
      onChanged: (ExpenseType value) {
        setSelectedType(value);
      },
    );
  }

  setSelectedType(ExpenseType type) {
    setState(() {
      print(type.description);
      widget._character = type;
    });
  }
}
