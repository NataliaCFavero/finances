import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/presenter/new_expense_presenter.dart';
import 'package:finances/repository/app_database.dart';
import 'package:flutter/cupertino.dart';

class NewExpenseUseCase {
  Future<List<ExpenseType>> getListExpenseType() {}

  Future<void> createExpense(double value, ExpenseType category) {}
}

class NewExpenseUseCaseImpl implements NewExpenseUseCase {
  NewExpensePresenterImpl presenter;

  NewExpenseUseCaseImpl({this.presenter});

  Future<List<ExpenseType>> getListExpenseType() {
    return findAllExpenseType().then((types) {
      if (types.length < 1) {
        types = _createListExpenseTypeOnDb();
      }
      return types;
    });
  }

  Future<void> createExpense(double value, ExpenseType category) {
    if (category != null && value > 0) {
      Expense expense = Expense(value: value, category: category);

      FutureBuilder<int>(
          initialData: 0,
          future: saveExpense(expense),
          builder: (context, snapshot) {
            final int id = snapshot.data;
            if (id > 0) {
              presenter.successSaveExpense(expense);
            }
          });
    } else {
      presenter.showErrorToCreateExpense();
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
