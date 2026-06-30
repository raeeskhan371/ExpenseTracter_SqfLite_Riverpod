import 'package:expense_tracker_sqflite/database/local_databas/db_helper.dart';
import 'package:expense_tracker_sqflite/models/budget_model.dart';
import 'package:flutter/material.dart';

class SetBalanceScreen extends StatefulWidget {
  const SetBalanceScreen({super.key});

  @override
  State<SetBalanceScreen> createState() => _SetBalanceScreenState();
}

class _SetBalanceScreenState extends State<SetBalanceScreen> {
  TextEditingController balance = TextEditingController();

  final dbref = DbHelper.getInstance;
  Future<BudgetModel?> getDataFromDb() async {
    return await dbref.getBudget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Balance")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your balance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: balance,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "e.g. 5000",
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final setBalance = double.parse(balance.text);

                  dbref.insertBalance(
                    amount: setBalance,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                },
                child: const Text("Save Balance"),
              ),
            ),

            const SizedBox(height: 20),

            FutureBuilder<BudgetModel?>(
              future: getDataFromDb(),
              builder: (context, snapshot) {
                final budget = snapshot.data!;
                return ListTile(
                  leading: Text(
                    " ${budget.amount}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    children: [
                      Text("${budget.createdAt}"),
                      Text("${budget.updatedAt}"),
                    ],
                  ),
                  trailing: GestureDetector(
                    onTap: () async {
                      final setBalance = double.parse(balance.text);
                      await dbref.updateBalance(
                        amount: setBalance,
                        updatedAt: DateTime.now(),
                        id: budget.id!,
                      );
                    },

                    child: Icon(Icons.edit, color: Colors.blue),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
