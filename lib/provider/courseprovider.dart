import 'package:flutter/cupertino.dart';

class Courseprovider extends ChangeNotifier {
  String _uid = "";
  String get uid => _uid;
  void uiSetter(String uid) {
    _uid = uid;
  }
}
