import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/constant/constants.dart';
import 'package:expenz_app/models/expence_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:flutter/material.dart';

class AddNewScreen extends StatefulWidget {
  const AddNewScreen({super.key});

  @override
  State<AddNewScreen> createState() => _AddNewScreenState();
}

class _AddNewScreenState extends State<AddNewScreen> {
  //state to track the expense or income
  int _selectedMethode = 0;

  ExpenseCategory _expenseCategory = ExpenseCategory.health;
  IncomeCategory _incomeCategory = IncomeCategory.salary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedMethode == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefalutPadding),
            child: Stack(
              children: [
                //tabs
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefalutPadding,
                  ),
                  child: Container(
                    //expense and income tabs
                    height: MediaQuery.of(context).size.height * 0.06,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap:
                              () => setState(() {
                                _selectedMethode = 0;
                              }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 0 ? kRed : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 60,
                              ),
                              child: Text(
                                "Expense",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _selectedMethode == 0 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              () => setState(() {
                                _selectedMethode = 1;
                              }),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethode == 1 ? kGreen : kWhite,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 60,
                              ),
                              child: Text(
                                "Income",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _selectedMethode == 1 ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //amount filed
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefalutPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How Much?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          // ignore: deprecated_member_use
                          color: kLightGrey.withOpacity(0.8),
                        ),
                      ),
                      TextField(
                        style: TextStyle(
                          fontSize: 60,
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "0",
                          hintStyle: TextStyle(
                            fontSize: 60,
                            // ignore: deprecated_member_use
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                //user data form
                Container(
                  height: 300,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.30,
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kDefalutPadding,
                      vertical: 20,
                    ),
                    child: Form(
                      child: Column(
                        children: [
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: kDefalutPadding,
                              ),
                            ),
                            items:
                                _selectedMethode == 0
                                    ? ExpenseCategory.values.map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList()
                                    : IncomeCategory.values.map((category) {
                                      return DropdownMenuItem(
                                        value: category,
                                        child: Text(category.name),
                                      );
                                    }).toList(),
                            value:
                                _selectedMethode == 0
                                    ? _expenseCategory
                                    : _incomeCategory,
                            onChanged: (value) {
                              setState(() {
                                _selectedMethode == 0
                                    ? _expenseCategory =
                                        value as ExpenseCategory
                                    : _incomeCategory = value as IncomeCategory;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
