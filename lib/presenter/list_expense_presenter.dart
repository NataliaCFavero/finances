import 'package:finances/models/chart.dart';
import 'package:finances/models/expense.dart';
import 'package:finances/view/screens/list_expense.dart';

abstract class ListExpensePresenter {
  void onLoadExpenseList(List<Expense> expenses) {}

  void onError() {}

  void onLoadChart(Map<int, ChartCategory> mapList) {}
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

  @override
  void onLoadChart(Map<int, ChartCategory> mapList) {
    // TODO: implement onLoadChart
  }
}
