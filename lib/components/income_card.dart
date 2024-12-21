import 'package:damaz/services/balance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/expense_data.dart';
import '../data/income_data.dart';
import '../datetime/date_time_helper.dart';

class IncomeCard extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime startOfWeek;

  const IncomeCard({
    required this.name,
    required this.amount,
    required this.startOfWeek,
    super.key});

  // calculate max amount
  double calculateMax(
      IncomeData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      ) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyIncomeSummary()[sunday] ?? 0,
      value.calculateDailyIncomeSummary()[monday] ?? 0,
      value.calculateDailyIncomeSummary()[tuesday] ?? 0,
      value.calculateDailyIncomeSummary()[wednesday] ?? 0,
      value.calculateDailyIncomeSummary()[thursday] ?? 0,
      value.calculateDailyIncomeSummary()[friday] ?? 0,
      value.calculateDailyIncomeSummary()[saturday] ?? 0,
    ];

    // sort from smallest to largest
    values.sort();
    // get largest amount (which is at the end of the sorted list)
    // and increase the cap slightly so the graph looks almost full
    max = values.last = 1.1;

    return max == 0 ? 100 : max;
  }

  // calculate the week total
  String calculateWeekTotalIncome(
      IncomeData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      ) {
    List<double> values = [
      value.calculateDailyIncomeSummary()[sunday] ?? 0,
      value.calculateDailyIncomeSummary()[monday] ?? 0,
      value.calculateDailyIncomeSummary()[tuesday] ?? 0,
      value.calculateDailyIncomeSummary()[wednesday] ?? 0,
      value.calculateDailyIncomeSummary()[thursday] ?? 0,
      value.calculateDailyIncomeSummary()[friday] ?? 0,
      value.calculateDailyIncomeSummary()[saturday] ?? 0,
    ];

    double totalIncome = 0;
    for (int i = 0; i < values.length; i++) {
      totalIncome += values[i];


    }
    return totalIncome.toStringAsFixed(2);

  }




  @override
  Widget build(BuildContext context) {
    final balanceProvider = Provider.of<BalanceProvider>(context);

    // get yyyymmdd for each day of this week
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    //balanceProvider.setTotalIncome(double.parse(calculateWeekTotalIncome(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)));
    // the red spending card
    return Consumer<IncomeData>(
      builder: (context, value, child) {
        // Calculate the total
        String totalIncomeStr = calculateWeekTotalIncome(
            value,
            sunday,
            monday,
            tuesday,
            wednesday,
            thursday,
            friday,
            saturday
        );

        // Convert to double and update the provider
        double totalIncome = double.parse(totalIncomeStr);
        balanceProvider.setTotalIncome(totalIncome);
        return SizedBox(
          height: 75,
          width: 200,
          child: Card(
            color: Color(0xFF1C5C3C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Income",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),

                  Text(
                    '\$${calculateWeekTotalIncome(
                        value,
                        sunday,
                        monday,
                        tuesday,
                        wednesday,
                        thursday,
                        friday,
                        saturday)}',
                    style: TextStyle(color: Color(0xFF05A31F)),
                  ),
                ],
              ),),


          ),
        );

      }
    );

  }
}
