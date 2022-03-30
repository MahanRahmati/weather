import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TimeFormat { t24, t12 }

final changeTimeFormat = ChangeNotifierProvider.autoDispose(
  (ref) => ChangeTimeFormatState(),
);

class ChangeTimeFormatState extends ChangeNotifier {
  TimeFormat? format = TimeFormat.t24;

  void t24() {
    format = TimeFormat.t24;
    notifyListeners();
  }

  void t12() {
    format = TimeFormat.t12;
    notifyListeners();
  }
}
