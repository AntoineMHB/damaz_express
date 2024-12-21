import 'package:flutter/material.dart';
import '';

class BalanceProvider extends ChangeNotifier {
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;

  double get totalIncome => _totalIncome;
  double get totalExpense => _totalExpense;

  void setTotalIncome(double value) {
    _totalIncome = value;
    notifyListeners();
  }

  void setTotalExpense(double value) {
    _totalExpense = value;
    notifyListeners();
  }

  double get balance => _totalIncome - _totalExpense;
}
