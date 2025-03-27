import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider extends ChangeNotifier {
  int _count = 0;
  get count => _count;

  double _totalPrice = 0;
  get totalPrice => _totalPrice;

  Future<void> setValue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setInt('count', _count);
    sp.setDouble('totalPrice', _totalPrice);
  }

  Future<void> getValue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    _count = sp.getInt('count') ?? 0;
    _totalPrice = sp.getDouble('totalPrice') ?? 0.0;
    notifyListeners();
  }

  increment() {
    _count++;
    setValue();
    notifyListeners();
  }

  decrement() {
    _count--;
    setValue();
    notifyListeners();
  }

  int getCounter() {
    getValue();
    return _count;
  }

  addPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    setValue();
  }

  removePrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    setValue();
    return _totalPrice;
  }

  double getPrice() {
    getValue();
    return _totalPrice;
  }
}
