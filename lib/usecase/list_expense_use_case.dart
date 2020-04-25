import 'package:finances/presenter/list_expense_presenter.dart';
import 'package:finances/repository/app_database.dart';
import 'package:finances/screens/list_expense.dart';

abstract class ListExpenseUseCase {
  void onLoadExpenseList() {}
}

class ListExpenseUseCaseImpl implements ListExpenseUseCase {
  ListExpensePresenterImpl _presenter;

  ListExpenseUseCaseImpl(this._presenter);

  @override
  void onLoadExpenseList() {
    findAllExpense()
        .then((expenses) {
      _presenter.onLoadExpenseList(expenses);
    }).catchError((onError) => _presenter.onError());
  }
}
