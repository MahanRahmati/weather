import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/providers/temp.dart';
import '/providers/theme.dart';
import '/providers/time.dart';
import '/strings.dart';

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
            title: Strings.theme,
            children: [
              ArnaRadioListTile(
                value: Theme.system,
                groupValue: themeMode,
                title: Strings.system,
                onChanged: (_) => ref.read(changeTheme.notifier).system(),
              ),
              ArnaRadioListTile(
                value: Theme.dark,
                groupValue: themeMode,
                title: Strings.dark,
                onChanged: (_) => ref.read(changeTheme.notifier).dark(),
              ),
              ArnaRadioListTile(
                value: Theme.light,
                groupValue: themeMode,
                title: Strings.light,
                onChanged: (_) => ref.read(changeTheme.notifier).light(),
              ),
            ],
          ),
          ArnaGroupedView(
            title: Strings.unit,
            children: [
              ArnaRadioListTile(
                value: Temp.celsius,
                groupValue: tempUnit,
                title: Strings.celsius,
                onChanged: (_) => ref.read(changeTempUnit.notifier).celsius(),
              ),
              ArnaRadioListTile(
                value: Temp.fahrenheit,
                groupValue: tempUnit,
                title: Strings.fahrenheit,
                onChanged: (_) =>
                    ref.read(changeTempUnit.notifier).fahrenheit(),
              ),
              ArnaRadioListTile(
                value: Temp.kelvin,
                groupValue: tempUnit,
                title: Strings.kelvin,
                onChanged: (_) => ref.read(changeTempUnit.notifier).kelvin(),
              ),
            ],
          ),
          ArnaGroupedView(
            title: Strings.timeFormat,
            children: [
              ArnaRadioListTile(
                value: TimeFormat.t24,
                groupValue: format,
                title: Strings.t24,
                onChanged: (_) => ref.read(changeTimeFormat.notifier).t24(),
              ),
              ArnaRadioListTile(
                value: TimeFormat.t12,
                groupValue: format,
                title: Strings.t12,
                onChanged: (_) => ref.read(changeTimeFormat.notifier).t12(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
