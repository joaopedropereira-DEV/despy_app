import 'package:flutter/material.dart';

import '../../core/models/model_transaction.dart';
import '../../core/services/data/data_transaction_service.dart';

class TransactionController with ChangeNotifier {
  // VARIABLES
  final List<TransactionModel> _trList = [];
  final _dataSource = DataService(uid: _uid);
  static String _uid = "";
  bool isLoading = false;

  // GETTERS
  List<TransactionModel> get transactions => [..._trList];

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

  TransactionModel getById(String id) {
    final transaction = _trList.where((tr) => tr.id == id) as TransactionModel;
    notifyListeners();
    return transaction;
  }

  /*

    -CONTROLLER-

    (GET) DATA FROM DATABASE AND RETURN TO CONTROLLER

    => Load Transaction

  */

  Future<void> load() async {
    toggleLoading();
    _trList.clear();
    Map<String, dynamic>? extractedData = await _dataSource.fetchData();
    extractedData.forEach((trID, trITEM) {
      if (trID == "Empty") {
        return;
      } else {
        trITEM["id"] = trID;
        final tr = TransactionModel.fromMap(trITEM);
        _trList.add(tr);
      }
    });
    notifyListeners();
    toggleLoading();
  }

  /*

    -CONTROLLER-

    (POST) DATA to DATABASE AND RETURN STATUSCODE

    => Create Transaction
    
  */

  Future<void> create(TransactionModel transaction) async {
    toggleLoading();
    _trList.add(transaction);
    notifyListeners();
    final statusCode = await _dataSource.createData(transaction.toMap());
    if (statusCode != 200) {
      _trList.remove(transaction);
      notifyListeners();
    }
    toggleLoading();
  }

  /*

    -CONTROLLER-

    (PATCH) DATA TO DATABASE AND RETURN STATUSCODE

    => Patch Transaction
    
  */

  Future<void> update(String id, TransactionModel updatedTR) async {
    toggleLoading();
    final index = _trList.indexWhere((tr) => tr.id == id);
    final existedTR = _trList[index];
    _trList[index] = updatedTR;
    notifyListeners();
    final statusCode = await _dataSource.patchData(id, updatedTR.toMap());
    if (statusCode >= 400 || statusCode >= 500) {
      _trList[index] = existedTR;
      notifyListeners();
    }
    toggleLoading();
  }

  /*

    -CONTROLLER-

    (DELETE) DATA TO DATABASE AND RETURN TO STATUSCODE

    => Delete Transaction
    
  */

  Future<void> remove(String id) async {
    final int index = _trList.indexWhere((tr) => tr.id == id);
    final elementTR = _trList[index];
    if (index >= 0) {
      _trList.remove(elementTR);
      notifyListeners();
      final statusCode = await _dataSource.deleteData(id);
      if (statusCode >= 400) {
        _trList.insert(index, elementTR);
        notifyListeners();
      }
    }
  }
}
