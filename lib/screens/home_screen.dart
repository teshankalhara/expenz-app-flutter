import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/models/expence_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/services/user_service.dart';
import 'package:expenz_app/widgets/expense_card.dart';
import 'package:expenz_app/widgets/income_expence_card.dart';
import 'package:expenz_app/widgets/line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomeList;

  const HomeScreen({
    super.key,
    required this.expensesList,
    required this.incomeList,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  double totalIncome = 0;
  double totalExpense = 0;

  @override
  void initState() {
    //get the username form the shared preferences
    UserService.getUserDeta().then((value) {
      if (value["username"] != null) {
        setState(() {
          username = value["username"]!;
        });
      }
    });

    setState(() {
      for (int i = 0; i < widget.incomeList.length; i++) {
        totalIncome += widget.incomeList[i].amount;
      }
      for (int i = 0; i < widget.expensesList.length; i++) {
        totalExpense += widget.expensesList[i].amount;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //main column
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: kMainColor.withOpacity(0.40),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    //bg column
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: kMainColor,
                              border: Border.all(color: kMainColor, width: 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'assets/images/user.jpg',
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            "Welcome $username",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: kMainColor,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IncomeExpenceCard(
                            title: "Income",
                            amount: totalIncome,
                            imageUrl: "assets/images/income.png",
                            bgcolor: kGreen,
                          ),
                          IncomeExpenceCard(
                            title: "Expense",
                            amount: totalExpense,
                            imageUrl: "assets/images/expense.png",
                            bgcolor: kRed,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(kDefalutPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Spend Frequency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 20),

                    //chart to show the spend frequency and the amount spent in a chart using fl_chart
                    LineChartSample(),
                  ],
                ),
              ),

              //recent transactions
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefalutPadding,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Recent Transactions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      //show the recent transactions
                      Column(
                        // Wrap with Column to ensure proper layout
                        children: [
                          widget.expensesList.isEmpty
                              ? const Text(
                                "No expenses added yet, add some expenses to see here",
                                style: TextStyle(fontSize: 16, color: kGrey),
                              )
                              : ListView.builder(
                                shrinkWrap:
                                    true, // Set shrinkWrap to true to allow the ListView to adapt to its content size
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: widget.expensesList.length,
                                itemBuilder: (context, index) {
                                  final expense = widget.expensesList[index];
                                  return ExpenseCard(
                                    title: expense.title,
                                    date: expense.date,
                                    amount: expense.amount,
                                    category: expense.category,
                                    description: expense.description,
                                    createdAt: expense.time,
                                  );
                                },
                              ),
                        ],
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
