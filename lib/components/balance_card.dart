import 'package:damaz/services/balance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final balanceProvider = Provider.of<BalanceProvider>(context);

    return  Consumer<BalanceProvider>(
      builder: (context, provider, child) => Padding(
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

                // THIS VALUE IS TO BE RECALCULATED. IT SHOULD BE THE BALANCE AMOUNT
                Column(

                  children: [
                    Text('\$${provider.balance.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),

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
    );

  }
}
