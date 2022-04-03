import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/models/daily.dart';
import '/providers/temp.dart';
import '/strings.dart';
import '/utils/functions.dart';

class DailyWidget extends ConsumerWidget {
  final List<Daily?> daily;
  final double timezoneOffset;

  const DailyWidget({
    Key? key,
    required this.daily,
    required this.timezoneOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temp = ref.watch(changeTempUnit);
    return ArnaList(
      title: Strings.daily,
      items: daily.map((daily) {
        DateTime dt = daily!.date!.add(
          Duration(seconds: timezoneOffset.toInt()),
        );
        String date = DateFormat('d').format(dt);
        return ArnaExpansionPanel(
          leading: Container(
            height: 42,
            width: 42,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: borderRadiusAll(42),
              color: circleBackgroundColor(context),
            ),
            padding: Styles.normal,
            child: SvgPicture.asset(
              'assets/images/${daily.weatherIcon}.svg',
            ),
          ),
          title: (DateFormat('d').format(DateTime.now()) == date)
              ? Strings.today
              : DateFormat('EEEE').format(dt),
          subtitle: daily.weatherDescription!.toTitleCase(),
          trailing: Padding(
            padding: Styles.horizontal,
            child: Row(
              children: [
                Text(
                  temp.tempUnit == Temp.celsius
                      ? "${daily.tempMax!.celsius!.ceil()}°"
                      : temp.tempUnit == Temp.fahrenheit
                          ? "${daily.tempMax!.fahrenheit!.ceil()}°"
                          : "${daily.tempMax!.kelvin!.ceil()}°",
                  style: ArnaTheme.of(context).textTheme.titleTextStyle,
                ),
                Text(
                  temp.tempUnit == Temp.celsius
                      ? " ${daily.tempMin!.celsius!.ceil()}°"
                      : temp.tempUnit == Temp.fahrenheit
                          ? " ${daily.tempMin!.fahrenheit!.ceil()}°"
                          : " ${daily.tempMin!.kelvin!.ceil()}°",
                  style: ArnaTheme.of(context).textTheme.subtitleTextStyle,
                ),
              ],
            ),
          ),
          child: Column(
            children: [
              rowBuilder(
                [
                  columnBuilder(
                    context,
                    Strings.pressure,
                    "${daily.pressure} hPa",
                  ),
                  columnBuilder(
                    context,
                    Strings.humidity,
                    "${daily.humidity}%",
                  ),
                ],
              ),
              rowBuilder(
                [
                  columnBuilder(
                    context,
                    Strings.pop,
                    "${(daily.pop! * 100).toInt()}%",
                  ),
                  columnBuilder(context, Strings.uvi, "${daily.uvi!.toInt()}"),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
