import 'package:damaz/bar%20graph/bar_graph.dart';
import 'package:damaz/data/expense_data.dart';
import 'package:damaz/data/income_data.dart';
import 'package:damaz/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const IncomeSummary({
    super.key,
    required this.startOfWeek,
  });

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

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total.toStringAsFixed(2);

  }


  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<IncomeData>(
      builder: (context, value, child) =>
          Column(
            children: [
              // week total
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Color(0xFF1C5C3C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Card tile
                        Text(
                          'Your incomes in this week',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8.0),

                        //card content
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Week Total:",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),

                            Text('\$${calculateWeekTotalIncome(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF05A31F),
                              ),),

                          ],
                        )
                      ],
                    ),
                  ),

                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(25.0),
              //   child: Row(
              //     children: [
              //       Text(
              //           'Week Total:',
              //        style: TextStyle(fontWeight: FontWeight.bold),),
              //       Text('\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}')
              //     ],
              //   ),
              // ),

              // bar graph
              SizedBox(
                height: 200,
                child: MyBarGraph(
                  maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
                  sunAmount: value.calculateDailyIncomeSummary()[sunday] ?? 0,
                  monAmount: value.calculateDailyIncomeSummary()[monday] ?? 0,
                  tueAmount: value.calculateDailyIncomeSummary()[tuesday] ?? 0,
                  wedAmount: value.calculateDailyIncomeSummary()[wednesday] ?? 0,
                  thurAmount: value.calculateDailyIncomeSummary()[thursday] ?? 0,
                  friAmount:value.calculateDailyIncomeSummary()[friday] ?? 0,
                  satAmount: value.calculateDailyIncomeSummary()[saturday] ?? 0,),
              ),
            ],
          ),
    );
  }
}