import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Temp { celsius, fahrenheit, kelvin }

final changeTempUnit = ChangeNotifierProvider.autoDispose(
  (ref) => ChangeTempUnitState(),
);

class ChangeTempUnitState extends ChangeNotifier {
  Temp? tempUnit = Temp.celsius;

  void celsius() {
    tempUnit = Temp.celsius;
    notifyListeners();
  }

  void fahrenheit() {
    tempUnit = Temp.fahrenheit;
    notifyListeners();
  }

  void kelvin() {
    tempUnit = Temp.kelvin;
    notifyListeners();
  }
}
