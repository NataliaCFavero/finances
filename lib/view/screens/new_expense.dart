import 'package:finances/view/components/input_text.dart';
import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/presenter/new_expense_presenter.dart';
import 'package:finances/usecase/new_expense_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

const _titleAppBar = 'Nova Despesa';
const _labelValue = 'Valor';
const _hintValue = '00.00';
const _buttonAdd = 'Adicionar';
const _labelCreateExpense = 'Criar Despesa';
const _labelMsgError = 'Insira um valor e selecione o tipo da sua despesa.';
const _labelBtnError = 'Ok';

class NewExpenseView {
  void finishScreen(Expense expense) {}

  void onLoadCategoriesList(List<Category> categories) {}

  void onErrorCategoriesList() {}

  void showErrorToCreateExpense() {}
}

class NewExpense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewExpenseState();
  }
}

class NewExpenseState extends State<NewExpense> implements NewExpenseView {
  final MoneyMaskedTextController _controllerExpenseValue =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  RadioListCategoryWidget _statefulWidget;
  NewExpenseUseCaseImpl _useCaseImpl;
  NewExpensePresenterImpl _presenterImpl;
  List<Category> _typesList;

  NewExpenseState() {
    this._presenterImpl = NewExpensePresenterImpl(this);
    this._useCaseImpl = NewExpenseUseCaseImpl(presenter: _presenterImpl);
  }

  @override
  void initState() {
    super.initState();
    _useCaseImpl.getListCategories();
  }

  @override
  void onLoadCategoriesList(List<Category> typesList) {
    setState(() {
      _typesList = typesList;
      _statefulWidget = RadioListCategoryWidget(list: _typesList);
    });
  }

  @override
  void onErrorCategoriesList() {
    print('Error');
  }

  void createExpense(BuildContext context) {
    _useCaseImpl.createExpense(
        _controllerExpenseValue.numberValue, _statefulWidget._category);
  }

  void finishScreen(Expense expense) {
    Navigator.pop(context, expense);
  }

  Future<void> showErrorToCreateExpense() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_labelCreateExpense),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(_labelMsgError),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(_labelBtnError),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_statefulWidget == null) {
      return Center(
          child: Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: CircularProgressIndicator()));
    } else {
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
              _statefulWidget,
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
  }
}

class RadioListCategoryWidget extends StatefulWidget {
  Category _category;
  final List<Category> list;

  RadioListCategoryWidget({Key key, this.list}) : super(key: key);

  @override
  _RadioListCategoryWidgetState createState() =>
      _RadioListCategoryWidgetState();
}

class _RadioListCategoryWidgetState extends State<RadioListCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: createList(widget.list),
    );
  }

  List<RadioListTile> createList(List<Category> categories) {
    List<RadioListTile> listTile = [];
    for (Category category in categories) {
      listTile.add(createRadioList(category));
    }
    return listTile;
  }

  RadioListTile createRadioList(Category category) {
    return RadioListTile<Category>(
      title: Text(category.description),
      value: category,
      groupValue: widget._category,
      onChanged: (Category value) {
        setSelectedType(value);
      },
    );
  }

  setSelectedType(Category type) {
    setState(() {
      widget._category = type;
    });
  }
}
