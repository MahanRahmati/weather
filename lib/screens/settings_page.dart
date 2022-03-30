import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/temp.dart';
import '/providers/theme.dart';
import '/providers/time.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Theme? themeMode = ref.watch(changeTheme).theme;
    Temp? tempUnit = ref.watch(changeTempUnit).tempUnit;
    TimeFormat? format = ref.watch(changeTimeFormat).format;
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
                value: Temp.celsius,
                groupValue: tempUnit,
                title: "Celsius",
                onChanged: (_) => ref.read(changeTempUnit.notifier).celsius(),
              ),
              ArnaRadioListTile(
                value: Temp.fahrenheit,
                groupValue: tempUnit,
                title: "Fahrenheit",
                onChanged: (_) =>
                    ref.read(changeTempUnit.notifier).fahrenheit(),
              ),
              ArnaRadioListTile(
                value: Temp.kelvin,
                groupValue: tempUnit,
                title: "Kelvin",
                onChanged: (_) => ref.read(changeTempUnit.notifier).kelvin(),
              ),
            ],
          ),
          ArnaGroupedView(
            title: "Time format",
            children: [
              ArnaRadioListTile(
                value: TimeFormat.t24,
                groupValue: format,
                title: "13:00",
                onChanged: (_) => ref.read(changeTimeFormat.notifier).t24(),
              ),
              ArnaRadioListTile(
                value: TimeFormat.t12,
                groupValue: format,
                title: "1:00 PM",
                onChanged: (_) => ref.read(changeTimeFormat.notifier).t12(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
