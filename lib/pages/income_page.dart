import 'package:damaz/components/expense_card.dart';
import 'package:damaz/components/expense_summary.dart';
import 'package:damaz/components/income_summary.dart';
import 'package:damaz/components/my_drawer.dart';
import 'package:damaz/data/expense_data.dart';
import 'package:damaz/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/expense_tile.dart';
import '../components/income_tile.dart';
import '../data/income_data.dart';
import '../models/income_item.dart';
import '../services/languageProvider.dart';
import '../themes/theme_provider.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {

  // text controllers
  final newIncomeNameController = TextEditingController();
  final newIncomeDollarController = TextEditingController();
  final newIncomeCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepare data on startup
    Provider.of<IncomeData>(context, listen: false).prepareData();
  }

  // add new income
  void addNewIncome() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add new income"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name
            TextField(
              controller: newIncomeNameController,
              decoration: const InputDecoration(
                hintText: "Income name",
              ),
            ),

            Row(
              children: [
                // dollars
                Expanded(
                  child: TextField(
                    controller: newIncomeDollarController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Dollars",
                    ),
                  ),
                ),

                // cents
                Expanded(
                  child: TextField(
                    controller: newIncomeCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Cents",
                    ),
                  ),
                ),
              ],)
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: Text("Save"),
          ),

          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // delete income
  void deleteIncome(IncomeItem income) {
    Provider.of<IncomeData>(context, listen: false).deleteIncome(income);
  }

  // save
  void save() {
    // put dollars and cents together
    String amount = '${newIncomeDollarController.text}.${newIncomeCentsController.text}';

    // create income item
    IncomeItem newIncome = IncomeItem(
      name: newIncomeNameController.text,
      amount: amount,
      dateTime: DateTime.now(),
    );
    // add the new expense
    Provider.of<IncomeData>(context, listen: false).addNewIncome(newIncome);
    Navigator.pop(context);
    clear();

  }

  // cancel
  void cancel() {
    Navigator.pop(context);
    clear();

  }

  // clear controller
  void clear(){
    newIncomeNameController.clear();
    newIncomeDollarController.clear();
    newIncomeCentsController.clear();

  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Consumer<IncomeData>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text("Incomes"),
          ),
          drawer: MyDrawer(),
          backgroundColor: Theme.of(context).colorScheme.surface,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            onPressed: addNewIncome,
            child: Icon(Icons.add),
          ),
          body: ListView(children: [
            // welcoming message
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.welcomeDevicesPage,
                style: TextStyle(fontSize: 20, color: Colors.grey[700]),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Text(
            //     "ALPHIE",
            //     style: GoogleFonts.bebasNeue(
            //       fontSize: 25,
            //     ),
            //   ),
            // ),

            // weekly summary
            IncomeSummary(startOfWeek: value.startOfWeekDate(),),

            const SizedBox(height: 20,),

            // expense list

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "All your incomes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllIncomeList().length,
                itemBuilder: (context, index) => IncomeTile(
                  name: value.getAllIncomeList()[index].name,
                  amount: value.getAllIncomeList()[index].amount,
                  dateTime: value.getAllIncomeList()[index].dateTime,
                  deleteTapped: (p0) =>
                      deleteIncome(value.getAllIncomeList()[index]),
                )
            ),
          ],)
      ),
    );
  }
}