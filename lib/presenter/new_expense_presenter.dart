import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/screens/new_expense.dart';

abstract class NewExpensePresenter {
  void showListExpenseType(List<ExpenseType> listTypes) {}

  void onErrorExpenseTypeList() {}

  void successSaveExpense(Expense expense) {}

  void onErrorToCreateExpense() {}
}

class NewExpensePresenterImpl implements NewExpensePresenter {
  NewExpenseView _view;

  NewExpensePresenterImpl(this._view);

  void showListExpenseType(List<ExpenseType> listTypes) {
    _view.onLoadExpenseTypeList(listTypes);
  }

  @override
  void onErrorExpenseTypeList() {
    _view.onErrorExpenseTypeList();
  }

  @override
  void successSaveExpense(Expense expense) {
    _view.finishScreen(expense);
  }

  @override
  void onErrorToCreateExpense() {
    _view.showErrorToCreateExpense();
  }
}
