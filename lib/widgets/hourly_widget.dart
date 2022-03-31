import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/models/hourly.dart';
import '/providers/temp.dart';
import '/providers/time.dart';
import '/strings.dart';

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
                              ? DateFormat.Hm().format(hourly!.date!)
                              : DateFormat.jm().format(hourly!.date!),
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
                            color: const Color(0x21000000),
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
                              ? hourly.temperature!.celsius!.ceil().toString() +
                                  "°"
                              : temp.tempUnit == Temp.fahrenheit
                                  ? hourly.temperature!.fahrenheit!
                                          .ceil()
                                          .toString() +
                                      "°"
                                  : hourly.temperature!.kelvin!
                                          .ceil()
                                          .toString() +
                                      "°",
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
