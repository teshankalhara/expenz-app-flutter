import 'dart:convert';

import 'package:expenz_app/models/expence_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //expsense list
  List<Expense> expenseList = [];

  //expense key store
  static const String _expenseKey = 'expenses';

  //save expense to local storage
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);
      //convert to existing expense to a list of expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects =
            existingExpenses
                .map((e) => Expense.fromJson(jsonDecode(e)))
                .toList();
      }
      existingExpenseObjects.add(expense);

      //convert the list of expense objects to a list of strings
      List<String> expenseStrings =
          existingExpenseObjects.map((e) => json.encode(e.toJson())).toList();
      //save the updated list to local storage
      await prefs.setStringList(_expenseKey, expenseStrings);
      //show message to user

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense added successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error on Adding Expense!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //load expenses from local storage
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingExpenses = prefs.getStringList(_expenseKey);

    //convert to existing expense to a list of expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses =
          existingExpenses
              .map((e) => Expense.fromJson(json.decode(e)))
              .toList();
    }
    return loadedExpenses;
  }

  //delete expense from local storage
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);
      //convert to existing expense to a list of expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects =
            existingExpenses
                .map((e) => Expense.fromJson(json.decode(e)))
                .toList();
      }
      //remove the expense with the given id
      existingExpenseObjects.removeWhere((e) => e.id == id);

      //convert the list of expense objects to a list of strings
      List<String>? updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJson())).toList();

      //save the updated list to local storage
      await prefs.setStringList(_expenseKey, updatedExpenses);
      //show message to user
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense deleted successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error on Deleting Expense!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Future<void> deleteAllExpenses(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // Clear all incomes from shared preferences
      await prefs.remove(_expenseKey);

      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All expenses deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error on Deleting All Expenses!'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
