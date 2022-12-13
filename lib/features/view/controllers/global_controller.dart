import 'package:despy_app/features/core/models/model_category.dart';
import 'package:despy_app/features/core/services/repository/repository_category_data.dart';
import 'package:despy_app/features/core/services/repository/repository_transaction_data.dart';
import 'package:flutter/material.dart';
import '../../core/models/model_transaction.dart';

class GlobalController with ChangeNotifier {
  // VARIABLES
  final List<TransactionModel> _transactionList = [];
  final List<CategoryModel> _categoryList = [];
  final _datasSources = {
    "Transaction": RepositoryTransaction(uid: _uid),
    "Category": RepositoryCategory(),
  };
  static String _uid = "";
  bool isLoading = false;

  // GETTERS
  List<TransactionModel> get transactions => [..._transactionList];
  List<CategoryModel> get categories => [..._categoryList];

  // FUNCTIONS
  void getUserId() {
    // Code to get User ID
    _uid = "(SOURCE ID HERE)";
    notifyListeners();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  TransactionModel getTransactionById(String id) {
    final transaction =
        _transactionList.where((tr) => tr.id == id) as TransactionModel;
    notifyListeners();
    return transaction;
  }

  CategoryModel getCategoryById(String id) {
    final category = _categoryList.where((tr) => tr.id == id) as CategoryModel;
    notifyListeners();
    return category;
  }

  /*

    -CONTROLLER-

    (GET) DATA FROM DATABASE AND RETURN TO CONTROLLER

    => Load Transaction & Category

  */

  Future<void> loadAllContent() async {
    toggleLoading();
    // Transaction
    _transactionList.clear();
    final dataSourceTransaction =
        _datasSources["Transaction"] as RepositoryTransaction;
    Map<String, dynamic>? extractedTransaction =
        await dataSourceTransaction.findAllTransaction();
    extractedTransaction.forEach((transactionID, transactionITEM) {
      if (transactionID == "Empty") {
        return;
      } else {
        transactionITEM["id"] = transactionID;
        final tr = TransactionModel.fromMap(transactionITEM);
        _transactionList.add(tr);
      }
    });
    notifyListeners();
    _categoryList.clear();
    final dataSourceCategory = _datasSources["Category"] as RepositoryCategory;
    Map<String, dynamic>? extractedCategory =
        await dataSourceCategory.findAllCategories();
    extractedCategory.forEach((categoryID, categoryITEM) {
      if (categoryID == "Empty") {
        return;
      } else {
        categoryITEM["id"] = categoryID;
        final tr = TransactionModel.fromMap(categoryITEM);
        _transactionList.add(tr);
      }
    });
    notifyListeners();

    // Category

    toggleLoading();
  }

  /*

    -CONTROLLER-

    (POST) DATA to DATABASE AND RETURN STATUSCODE

    => Create Transaction
    
  */

  Future<void> createTransaction(TransactionModel transaction) async {
    toggleLoading();
    final dataSource = _datasSources["Transaction"] as RepositoryTransaction;
    _transactionList.add(transaction);
    notifyListeners();
    final statusCode = await dataSource.readNewTransaction(transaction.toMap());
    if (statusCode != 200) {
      _transactionList.remove(transaction);
      notifyListeners();
    }
    toggleLoading();
  }

  /*

    -CONTROLLER-

    (POST) DATA to DATABASE AND RETURN STATUSCODE

    => Create Category
    
  */

  Future<void> createCategory(CategoryModel category) async {
    toggleLoading();
    final dataSource = _datasSources["Category"] as RepositoryCategory;
    _categoryList.add(category);
    notifyListeners();
    final statusCode = await dataSource.readNewCategory(category.toMap());
    if (statusCode != 200) {
      _categoryList.remove(category);
      notifyListeners();
    }
    toggleLoading();
  }

  /*

    -CONTROLLER-

    (PATCH) DATA TO DATABASE AND RETURN STATUSCODE

    => Patch Transaction
    
  */

  Future<void> updateTransaction(String id, TransactionModel updatedTR) async {
    toggleLoading();
    final dataSource = _datasSources["Transaction"] as RepositoryTransaction;
    final index = _transactionList.indexWhere((tr) => tr.id == id);
    final existedTR = _transactionList[index];
    _transactionList[index] = updatedTR;
    notifyListeners();
    final statusCode = await dataSource.patchTransaction(id, updatedTR.toMap());
    if (statusCode >= 400 || statusCode >= 500) {
      _transactionList[index] = existedTR;
      notifyListeners();
    }
    toggleLoading();
  }

  /*

    -CONTROLLER-

    (PATCH) DATA TO DATABASE AND RETURN STATUSCODE

    => Patch Category
    
  */

  Future<void> updateCategory(String id, CategoryModel updatedTR) async {
    toggleLoading();
    final dataSource = _datasSources["Category"] as RepositoryCategory;
    final index = _categoryList.indexWhere((tr) => tr.id == id);
    final existedTR = _categoryList[index];
    _categoryList[index] = updatedTR;
    notifyListeners();
    final statusCode = await dataSource.patchCategory(id, updatedTR.toMap());
    if (statusCode >= 400 || statusCode >= 500) {
      _categoryList[index] = existedTR;
      notifyListeners();
    }
    toggleLoading();
  }

  /*

    -CONTROLLER-

    (DELETE) DATA TO DATABASE AND RETURN TO STATUSCODE

    => Delete Transaction
    
  */

  Future<void> removeTransaction(String id) async {
    final dataSource = _datasSources["Transaction"] as RepositoryTransaction;
    final int index = _transactionList.indexWhere((tr) => tr.id == id);
    final elementTR = _transactionList[index];
    if (index >= 0) {
      _transactionList.remove(elementTR);
      notifyListeners();
      final statusCode = await dataSource.deleteTransaction(id);
      if (statusCode >= 400) {
        _transactionList.insert(index, elementTR);
        notifyListeners();
      }
    }
  }

  /*

    -CONTROLLER-

    (DELETE) DATA TO DATABASE AND RETURN TO STATUSCODE

    => Delete Category
    
  */

  Future<void> removeCategory(String id) async {
    final dataSource = _datasSources["Category"] as RepositoryCategory;
    final int index = _categoryList.indexWhere((tr) => tr.id == id);
    final elementTR = _categoryList[index];
    if (index >= 0) {
      _categoryList.remove(elementTR);
      notifyListeners();
      final statusCode = await dataSource.deleteCategory(id);
      if (statusCode >= 400) {
        _categoryList.insert(index, elementTR);
        notifyListeners();
      }
    }
  }
}
