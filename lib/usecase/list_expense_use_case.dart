import 'package:charts_flutter/flutter.dart';
import 'package:finances/models/chart.dart';
import 'package:finances/models/expense.dart';
import 'package:finances/presenter/list_expense_presenter.dart';
import 'package:finances/repository/app_database.dart';
import 'package:finances/repository/expense_dao.dart';

abstract class ListExpenseUseCase {
  void onLoadExpenseList() {}

  void groupListExpense(List<Expense> listExpense) {}
}

class ListExpenseUseCaseImpl implements ListExpenseUseCase {
  ListExpensePresenterImpl _presenter;
  ExpenseDao _expenseDao;

  ListExpenseUseCaseImpl(this._presenter) {
    this._expenseDao = ExpenseDao();
  }

  @override
  void onLoadExpenseList() {
    _expenseDao.findAllExpense().then((expenses) {
      _presenter.onLoadExpenseList(expenses);
    }).catchError((onError) => _presenter.onError());
  }

  @override
  void groupListExpense(List<Expense> listExpense) {
    ChartCategory chartCategory;

    Map<int, ChartCategory> mapList = Map<int, ChartCategory>();

    for (Expense expense in listExpense) {
      List<Expense> list = listExpense
          .where((f) => f.category.index == expense.category.index)
          .toList();

      double total = 0;
      list.forEach((f) => total += f.value);

      chartCategory = ChartCategory(
          total, expense.category, Color.fromHex(code: expense.category.color));
      mapList.putIfAbsent(expense.category.index, () => chartCategory);
    }

    _presenter.onLoadChart(mapList);
  }
}
