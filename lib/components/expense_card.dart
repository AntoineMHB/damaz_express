import 'package:damaz/bar%20graph/bar_graph.dart';
import 'package:damaz/components/income_card.dart';
import 'package:damaz/components/spending_card.dart';
import 'package:damaz/data/expense_data.dart';
import 'package:damaz/datetime/date_time_helper.dart';
import 'package:damaz/services/balance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'balance_card.dart';

class ExpenseCard extends StatelessWidget {

  final DateTime startOfWeek;
  const ExpenseCard({
    super.key,
    required this.startOfWeek,
  });

  // calculate max amount
  double calculateMax(
      ExpenseData value,
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
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    // sort from smallest to largest
    values.sort();
    // get largest amount (which is at the end of the sorted list)
    // and increase the cap slightly so the graph looks almost full
    max = values.last = 1.1;

    return max == 0 ? 100 : max;
  }

  // calculate balance


  // calculate the week total
  double calculateWeekTotal(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday,
      ) {
    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (int i = 0; i < values.length; i++) {
      total += values[i];
    }
    return total;

  }


  @override
  Widget build(BuildContext context) {
    final totalIncome = Provider.of<BalanceProvider>(context).totalIncome;

    // get yyyymmdd for each day of this week
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) =>
          Column(
            children: [
              // week total
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color:Color(0xFF037065),
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
                        // Text(
                        //   'Your spending behaviour in this week',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 18.0,
                        //     color: Colors.orange.shade800,
                        //   ),
                        // ),
                        // THIS VALUE IS TO BE RECALCULATED. IT SHOULD BE THE BALANCE AMOUNT
                        Column(

                          children: [
                            Consumer<BalanceProvider>(
                              builder:(context, balanceProvider, child) {

                              return Text('\$${balanceProvider.totalIncome - calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),);
                                 }
                            ),

                            const SizedBox(height: 5.0),

                            Text(
                              "Balance",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 15.0),

                        // The user name
                        Text(
                          "Alphonso Denis",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),

                        // Bank name and Icon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "CBL",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                            ),

                            // the icon
                            Icon(Icons.credit_card_outlined,
                            color: Colors.white,
                            size: 12,)

                          ],
                        )
                      ],
                    ),
                  ),

                ),
              ),

              SizedBox(height: 8.0,),

              // BalanceCard(),



              // Payment text
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text(
                        "Payments",
                    style: TextStyle(
                      //color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),

              // Payments cards
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [

                    // Text(
                    //     'Week Total:',
                    //  style: TextStyle(fontWeight: FontWeight.bold),),
                    // Text('\$${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}'),

                    // Green income card
                    IncomeCard(startOfWeek: value.startOfWeekDate(), name: '', amount: '',),

                    // Red spending card
                    SpendingCard(startOfWeek: value.startOfWeekDate(), name: '', amount: '',),

                    ]

                ),
              ),

              // bar graph
              // SizedBox(
              //   height: 200,
              //   child: MyBarGraph(
              //     maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
              //     sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
              //     monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
              //     tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
              //     wedAmount: value.calculateDailyExpenseSummary()[wednesday] ?? 0,
              //     thurAmount: value.calculateDailyExpenseSummary()[thursday] ?? 0,
              //     friAmount:value.calculateDailyExpenseSummary()[friday] ?? 0,
              //     satAmount: value.calculateDailyExpenseSummary()[saturday] ?? 0,),
              // ),
            ],
          ),
    );
  }
}