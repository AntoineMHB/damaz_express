import 'package:damaz/components/expense_summary.dart';
import 'package:damaz/components/my_drawer.dart';
import 'package:damaz/data/expense_data.dart';
import 'package:damaz/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../components/expense_tile.dart';
import '../services/languageProvider.dart';
import '../themes/theme_provider.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {

  // text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseDollarController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add new expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Add new expense"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // expense name
              TextField(
                controller: newExpenseNameController,
                decoration: const InputDecoration(
                  hintText: "Expense name",
                ),
              ),

              Row(
                children: [
                // dollars
                Expanded(
                  child: TextField(
                    controller: newExpenseDollarController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Dollars",
                    ),
                  ),
                ),

                // cents
                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
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

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // save
  void save() {
    // put dollars and cents together
    String amount = '${newExpenseDollarController.text}.${newExpenseCentsController.text}';

    // create expense item
    ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text,
        amount: amount,
        dateTime: DateTime.now(),
    );
    // add the new expense
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
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
    newExpenseNameController.clear();
    newExpenseDollarController.clear();
    newExpenseCentsController.clear();

  }
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text("Unifin Bunny: Expense Tracker"),
          ),
          drawer: MyDrawer(),
          backgroundColor: Theme.of(context).colorScheme.surface,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            onPressed: addNewExpense,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ALPHIE",
                style: GoogleFonts.bebasNeue(
                  fontSize: 25,
                ),
              ),
            ),

            // weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            const SizedBox(height: 20,),

            // expense list
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                  deleteTapped: (p0) =>
                    deleteExpense(value.getAllExpenseList()[index]),
                )
            ),
          ],)
        ),
    );
  }
}
