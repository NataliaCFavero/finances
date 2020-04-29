import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/view/screens/new_expense.dart';

abstract class NewExpensePresenter {
  void showListCategories(List<Category> listTypes) {}

  void onErrorCategoriesList() {}

  void successSaveExpense(Expense expense) {}

  void onErrorToCreateExpense() {}
}

class NewExpensePresenterImpl implements NewExpensePresenter {
  NewExpenseView _view;

  NewExpensePresenterImpl(this._view);

  void showListCategories(List<Category> listTypes) {
    _view.onLoadCategoriesList(listTypes);
  }

  @override
  void onErrorCategoriesList() {
    _view.onErrorCategoriesList();
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
