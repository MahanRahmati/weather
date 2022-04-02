import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/models/hourly.dart';
import '/providers/temp.dart';
import '/providers/time.dart';
import '/strings.dart';
import '/utils/functions.dart';

class HourlyWidget extends ConsumerWidget {
  final List<Hourly?> hourly;
  final double timezoneOffset;

  const HourlyWidget({
    Key? key,
    required this.hourly,
    required this.timezoneOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(changeTimeFormat);
    final temp = ref.watch(changeTempUnit);
    return ArnaGroupedView(
      title: Strings.today,
      children: [
        SizedBox(
          height: 140,
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
