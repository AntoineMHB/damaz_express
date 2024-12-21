import 'package:damaz/data/hive_dabatase.dart';
import 'package:damaz/datetime/date_time_helper.dart';
import 'package:damaz/models/income_item.dart';
import 'package:flutter/material.dart';
import '../models/income_item.dart';

class IncomeData extends ChangeNotifier {

  // list of all incomes
  List<IncomeItem> overallIncomeList = [];

  // get income list
  List<IncomeItem> getAllIncomeList() {
    return overallIncomeList;
  }

  // prepare data to display
  final db = HiverDataBase();
  void prepareData() {
    // if there exit data, get it
    if (db.readData().isNotEmpty) {
      overallIncomeList = db.readIncomes();

    }
  }

  // add new income
  void addNewIncome(IncomeItem newIncome) {
    overallIncomeList.add(newIncome);

    notifyListeners();
    db.readIncomes();
  }

  // delete income
  void deleteIncome(IncomeItem income) {
    overallIncomeList.remove(income);

    notifyListeners();
    db.saveIncomes(overallIncomeList);
  }

  // get weekday (mon, tues, etc) from a dataTime object
  String getDayName(DateTime dateTime) {
    switch(dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thur';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // get the date for the start of the week ( sunday )
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get today's date
    DateTime today = DateTime.now();

    // go backwards from today to find sunday
    for(int i = 0; i <  7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*

  convert overall list of incomes into a daily income summary

  e.g.

  overallIncomeList =
   */

  Map<String, double> calculateDailyIncomeSummary() {
    Map<String, double> dailyIncomeSummary = {
      // date (yyyymmdd) : amounttotalForDay
    };

    for (var income in overallIncomeList) {
      String date = convertDateTimeToString(income.dateTime);
      double amount = double.parse(income.amount);

      if (dailyIncomeSummary.containsKey(date)) {
        double currentAmount = dailyIncomeSummary[date]!;
        currentAmount += amount;
        dailyIncomeSummary[date] = currentAmount;
      } else {
        dailyIncomeSummary.addAll({date: amount});
      }
    }

    return dailyIncomeSummary;




  }



}