import 'dart:core';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_card/model/card_database.dart';
import 'package:shopping_card/model/card_model.dart';

class CartProvider extends ChangeNotifier {
  CartProvider() {
    getValue();
  }

  List<String> _selection = [];
  get selection => _selection;
  CardDataBase dataBase = CardDataBase();
  int _count = 0;
  get count => _count;

  double _totalPrice = 0;
  get totalPrice => _totalPrice;

  Future<void> setValue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setInt('count', _count);
    sp.setDouble('totalPrice', _totalPrice);
    sp.setStringList('selection', _selection);
  }

   Future<void> getValue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    _count = sp.getInt('count') ?? 0;
    _totalPrice = sp.getDouble('totalPrice') ?? 0.0;
    _selection = sp.getStringList('selection')!;
  }

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;
  Future<List<Cart>> getData() async {
    _cart = dataBase.getQueryList();
    return _cart;
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
    notifyListeners();
  }

  removePrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    setValue();
    notifyListeners();
  }

  double getPrice() {
    getValue();
    return _totalPrice;
  }
}
