import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/screens/new_expense.dart';

abstract class NewExpensePresenter {
  void showListExpenseType(List<ExpenseType> listTypes) {}

  void successSaveExpense(Expense expense) {}

  void showErrorToCreateExpense() {}
}

class NewExpensePresenterImpl implements NewExpensePresenter {
  NewExpenseView _view;

  NewExpensePresenterImpl(this._view);

  void showListExpenseType(List<ExpenseType> listTypes) {}

  @override
  void successSaveExpense(Expense expense) {
    _view.finishScreen(expense);
  }

  void showErrorToCreateExpense() {
    _view.showErrorToCreateExpense();
  }
}
