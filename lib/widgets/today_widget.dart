import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/models/hourly.dart';
import '/providers/temp.dart';
import '/providers/time.dart';
import '/strings.dart';
import '/utils/functions.dart';

class TodayWidget extends ConsumerWidget {
  final List<Hourly?> hourly;
  final double timezoneOffset;

  const TodayWidget({
    Key? key,
    required this.hourly,
    required this.timezoneOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(changeTimeFormat);
    final temp = ref.watch(changeTempUnit);
    return ArnaList(
      title: Strings.today,
      items: [
        Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: Styles.borderRadius,
            border: Border.all(
              color: ArnaDynamicColor.resolve(ArnaColors.borderColor, context),
            ),
            color: ArnaDynamicColor.resolve(ArnaColors.cardColor, context),
          ),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              scrollbars: false,
            ),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: hourly.map((hourly) {
                return Padding(
                  padding: Styles.largeHorizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: Styles.normal,
                        child: Text(
                          time.format == TimeFormat.t24
                              ? DateFormat('H').format(hourly!.date!)
                              : DateFormat('h a').format(hourly!.date!),
                          style:
                              ArnaTheme.of(context).textTheme.subtitleTextStyle,
                        ),
                      ),
                      Padding(
                        padding: Styles.normal,
                        child: Container(
                          height: 42,
                          width: 42,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: borderRadiusAll(42),
                            color: circleBackgroundColor(context),
                          ),
                          padding: Styles.normal,
                          child: SvgPicture.asset(
                            'assets/images/${hourly.weatherIcon}.svg',
                          ),
                        ),
                      ),
                      Padding(
                        padding: Styles.normal,
                        child: Text(
                          temp.tempUnit == Temp.celsius
                              ? "${hourly.temperature!.celsius!.ceil()}°"
                              : temp.tempUnit == Temp.fahrenheit
                                  ? "${hourly.temperature!.fahrenheit!.ceil()}°"
                                  : "${hourly.temperature!.kelvin!.ceil()}°",
                          style: ArnaTheme.of(context).textTheme.titleTextStyle,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
