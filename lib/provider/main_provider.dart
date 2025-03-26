import 'package:flutter/material.dart';
// import 'package:mynotes/services/fire_store_service.dart';

class MainProvider extends ChangeNotifier {
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  int selectedOption = 1;

  String selectedSort = 'createdTime';
  String tempSort = 'createdTime'; //

  void changeSeletedOption(int value) {
    selectedOption = value; // ✅ Corrected assignment
    notifyListeners(); // ✅ Notify listeners after update
  }

  void sort(String text) {
    tempSort = text;
    notifyListeners();
  }

  void sortMain() {
    selectedSort = tempSort;
    notifyListeners();
  }
}
