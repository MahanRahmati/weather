import 'package:arna/arna.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/models/hourly.dart';
import '/strings.dart';

class HourlyWidget extends StatelessWidget {
  final List<Hourly?> hourly;
  final double timezoneOffset;

  const HourlyWidget({
    Key? key,
    required this.hourly,
    required this.timezoneOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hourly.isNotEmpty
        ? Padding(
            padding: Styles.normal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Styles.padding,
                    0,
                    Styles.padding,
                    Styles.largePadding,
                  ),
                  child: Text(
                    Strings.hourly,
                    style: ArnaTheme.of(context).textTheme.titleTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 168,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(
                      scrollbars: false,
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: hourly.map((hourly) {
                        return ArnaCard(
                          child: Padding(
                            padding: Styles.largeHorizontal,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: Styles.normal,
                                  child: Text(
                                    DateFormat('H:00').format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        hourly!.dt!.toInt() * 1000,
                                        isUtc: true,
                                      ),
                                    ),
                                    style: ArnaTheme.of(context)
                                        .textTheme
                                        .subtitleTextStyle,
                                  ),
                                ),
                                Padding(
                                  padding: Styles.normal,
                                  child: SizedBox(
                                    height: Styles.buttonSize,
                                    width: Styles.buttonSize,
                                    child: SvgPicture.asset(
                                      'assets/images/${hourly.weather![0].icon}.svg',
                                      height: Styles.buttonSize,
                                      width: Styles.buttonSize,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: Styles.normal,
                                  child: Text(
                                    hourly.temp!.ceil().toString() + "°",
                                    style: ArnaTheme.of(context)
                                        .textTheme
                                        .titleTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
