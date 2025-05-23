import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/models/expence_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/widgets/expense_card.dart';
import 'package:expenz_app/widgets/income_card.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  final List<Expense> expenseList;
  final void Function(Expense) onDismissedExpense;

  final List<Income> incomeList;
  final void Function(Income) onDismissedIncome;

  const TransactionScreen({
    super.key,
    required this.expenseList,
    required this.onDismissedExpense,
    required this.incomeList,
    required this.onDismissedIncome,
  });

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "See your financial report",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: kMainColor,
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Expenses",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.expenseList.isEmpty
                          ? const Center(
                            child: Text(
                              "No expenses found",
                              style: TextStyle(fontSize: 16, color: kBlack),
                            ),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.expenseList.length,
                            itemBuilder: (context, index) {
                              final expense = widget.expenseList[index];
                              return Dismissible(
                                key: ValueKey(expense),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {
                                  setState(() {
                                    widget.onDismissedExpense(expense);
                                  });
                                },
                                child: ExpenseCard(
                                  title: expense.title,
                                  date: expense.date,
                                  amount: expense.amount,
                                  category: expense.category,
                                  description: expense.description,
                                  createdAt: expense.time,
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Income",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: kBlack,
                ),
              ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      widget.incomeList.isEmpty
                          ? const Center(
                            child: Text(
                              "No income found",
                              style: TextStyle(fontSize: 16, color: kBlack),
                            ),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.incomeList.length,
                            itemBuilder: (context, index) {
                              final income = widget.incomeList[index];
                              return Dismissible(
                                key: ValueKey(income),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {
                                  setState(() {
                                    widget.onDismissedIncome(income);
                                  });
                                },
                                child: IncomeCard(
                                  title: income.title,
                                  date: income.date,
                                  amount: income.amount,
                                  category: income.category,
                                  description: income.description,
                                  createdAt: income.time,
                                ),
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
