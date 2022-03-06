import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  // TODO Fix Settings
  var _temp = "0";
  var _time = "0";
  var _wind = "0";

  @override
  Widget build(BuildContext context) {
    Theme? themeMode = ref.watch(changeTheme).theme;
    return SingleChildScrollView(
      child: Column(
        children: [
          ArnaGroupedView(
            title: "Theme",
            children: [
              ArnaRadioListTile(
                value: Theme.system,
                groupValue: themeMode,
                title: "System",
                onChanged: (_) => ref.read(changeTheme.notifier).system(),
              ),
              ArnaRadioListTile(
                value: Theme.dark,
                groupValue: themeMode,
                title: "Dark",
                onChanged: (_) => ref.read(changeTheme.notifier).dark(),
              ),
              ArnaRadioListTile(
                value: Theme.light,
                groupValue: themeMode,
                title: "Light",
                onChanged: (_) => ref.read(changeTheme.notifier).light(),
              ),
            ],
          ),
          ArnaGroupedView(
            title: "Temperature unit",
            children: [
              ArnaRadioListTile(
                value: "0",
                groupValue: _temp,
                title: "Celsius",
                onChanged: (value) => setState(() => _temp = value as String),
              ),
              ArnaRadioListTile(
                value: "1",
                groupValue: _temp,
                title: "Fahrenheit",
                onChanged: (value) => setState(() => _temp = value as String),
              ),
            ],
          ),
          ArnaGroupedView(
            title: "Time format",
            children: [
              ArnaRadioListTile(
                value: "0",
                groupValue: _time,
                title: "1:00 PM",
                onChanged: (value) => setState(() => _time = value as String),
              ),
              ArnaRadioListTile(
                value: "1",
                groupValue: _time,
                title: "13:00",
                onChanged: (value) => setState(() => _time = value as String),
              ),
            ],
          ),
          ArnaGroupedView(
            title: "Wind speed unit",
            children: [
              ArnaRadioListTile(
                value: "0",
                groupValue: _wind,
                title: "meters/S",
                onChanged: (value) => setState(() => _wind = value as String),
              ),
              ArnaRadioListTile(
                value: "1",
                groupValue: _wind,
                title: "Kilometers/h",
                onChanged: (value) => setState(() => _wind = value as String),
              ),
              ArnaRadioListTile(
                value: "2",
                groupValue: _wind,
                title: "miles/h",
                onChanged: (value) => setState(() => _wind = value as String),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

enum Theme { system, dark, light }

final changeTheme = ChangeNotifierProvider.autoDispose(
  (ref) => ChangeThemeState(),
);

class ChangeThemeState extends ChangeNotifier {
  Theme? theme = Theme.system;

  void system() {
    theme = Theme.system;
    notifyListeners();
  }

  void dark() {
    theme = Theme.dark;
    notifyListeners();
  }

  void light() {
    theme = Theme.light;
    notifyListeners();
  }
}
