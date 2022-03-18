
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;
  void increse() {
    _count++;
    notifyListeners();
  }

  void decrease() {
    _count--;
    notifyListeners();
  }
}

class MyClass {


  @override
  call() {
    print("is this work?");
  }
}