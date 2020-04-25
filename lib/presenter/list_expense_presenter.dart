import 'package:finances/models/expense.dart';
import 'package:finances/view/screens/list_expense.dart';

abstract class ListExpensePresenter {
  void onLoadExpenseList(List<Expense> expenses) {}

  void onError() {}
}

class ListExpensePresenterImpl implements ListExpensePresenter {
  ListExpenseView _view;

  ListExpensePresenterImpl(this._view);

  @override
  void onLoadExpenseList(List<Expense> expenses) =>
      _view.onLoadExpenseList(expenses);

  @override
  void onError() {
    // TODO: implement onError
  }
}
