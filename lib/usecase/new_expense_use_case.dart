import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/presenter/new_expense_presenter.dart';
import 'package:finances/repository/app_database.dart';

class NewExpenseUseCase {
  void getListExpenseType() {}

  void createExpense(double value, ExpenseType category) {}
}

class NewExpenseUseCaseImpl implements NewExpenseUseCase {
  NewExpensePresenterImpl presenter;

  NewExpenseUseCaseImpl({this.presenter});

  void getListExpenseType() {
    findAllExpenseType().then((types) {
      if (types.length < 1) {
        types = _createListExpenseTypeOnDb();
      }
      presenter.showListExpenseType(types);
    }).catchError((onError) {
      print(onError);
      presenter.onErrorExpenseTypeList();
    });
  }

  void createExpense(double value, ExpenseType category) {
    if (category != null && value > 0) {
      Expense expense = Expense(value: value, category: category);
      saveExpense(expense).then((id) {
        presenter.successSaveExpense(expense);
      }).catchError((onError) {
        presenter.onErrorExpenseTypeList();
      });
    } else {
      presenter.onErrorToCreateExpense();
    }
  }

  List<ExpenseType> _createListExpenseTypeOnDb() {
    List<ExpenseType> expenseType = ExpenseType().newList();
    for (ExpenseType type in expenseType) {
      saveExpenseType(type);
    }
    return expenseType;
  }
}
