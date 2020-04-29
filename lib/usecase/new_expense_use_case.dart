import 'package:finances/models/expense.dart';
import 'package:finances/models/expense_types.dart';
import 'package:finances/presenter/new_expense_presenter.dart';
import 'package:finances/repository/app_database.dart';
import 'package:finances/repository/category_dao.dart';
import 'package:finances/repository/expense_dao.dart';

class NewExpenseUseCase {
  void getListCategories() {}

  void createExpense(double value, Category category) {}
}

class NewExpenseUseCaseImpl implements NewExpenseUseCase {
  NewExpensePresenterImpl presenter;
  CategoryDao _categoryDao;
  ExpenseDao _expenseDao;

  NewExpenseUseCaseImpl({this.presenter}) {
    _categoryDao = CategoryDao();
    _expenseDao = ExpenseDao();
  }

  void getListCategories() {
    _categoryDao.findAllCategories().then((categories) {
      if (categories.length < 1) {
        categories = _createListExpenseTypeOnDb();
      }
      presenter.showListCategories(categories);
    }).catchError((onError) {
      print(onError);
      presenter.onErrorCategoriesList();
    });
  }

  void createExpense(double value, Category category) {
    if (category != null && value > 0) {
      Expense expense = Expense(value: value, category: category);
      _expenseDao.saveExpense(expense).then((id) {
        presenter.successSaveExpense(expense);
      }).catchError((onError) {
        presenter.onErrorCategoriesList();
      });
    } else {
      presenter.onErrorToCreateExpense();
    }
  }

  List<Category> _createListExpenseTypeOnDb() {
    List<Category> categories = Category().newList();
    for (Category category in categories) {
      _categoryDao.saveExpenseType(category);
    }
    return categories;
  }
}
