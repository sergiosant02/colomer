import 'package:flutter/material.dart';

class ProviderPage with ChangeNotifier {
  int _page = 0;

  DateTime _date;

  get page {
    return _page;
  }

  set page(int pageRec) {
    this._page = pageRec;
    notifyListeners();
  }

  DateTime get date {
    return _date;
  }

  set date(DateTime date) {
    this._date = date;
    notifyListeners();
  }
}
