import 'package:expenz_app/constant/colors.dart';
import 'package:expenz_app/models/expence_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/screens/add_new_screen.dart';
import 'package:expenz_app/screens/budget_screen.dart';
import 'package:expenz_app/screens/home_screen.dart';
import 'package:expenz_app/screens/profile_screen.dart';
import 'package:expenz_app/screens/transactions_screen.dart';
import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/services/income_services.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  void fetchExpense() async {
    List<Expense> loadedExpense = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpense;
    });
  }

  void fetchIncome() async {
    List<Income> loadedIncome = await IncomeServices().loadIncomes();
    setState(() {
      incomeList = loadedIncome;
    });
  }

  void addNewExpense(Expense newExpense) {
    ExpenseService().saveExpenses(newExpense, context);
    setState(() {
      expenseList.add(newExpense);
    });
  }

  void addNewIncome(Income newIncome) {
    IncomeServices().saveIncome(newIncome, context);
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    fetchExpense();
    fetchIncome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      TransactionScreen(expenseList: expenseList),
      AddNewScreen(addExpense: addNewExpense, addIcome: addNewIncome),
      HomeScreen(),
      BudgetScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add, color: kWhite, size: 32),
            ),
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: "Budget",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
