import 'package:arna/arna.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/models/daily.dart';
import '/strings.dart';
import '/utils/functions.dart';

class DailyWidget extends StatelessWidget {
  final List<Daily?> daily;
  final double timezoneOffset;

  const DailyWidget({
    Key? key,
    required this.daily,
    required this.timezoneOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArnaList(
      title: Strings.daily,
      items: daily.map((daily) {
        DateTime dt = daily!.date!;
        String date = DateFormat('d').format(dt);
        int pop = (daily.pop! * 100).toInt();
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
                  "${daily.tempMax!.celsius!.ceil()}°",
                  style: ArnaTheme.of(context).textTheme.titleTextStyle,
                ),
                Text(
                  "  ${daily.tempMin!.celsius!.ceil()}°",
                  style: ArnaTheme.of(context).textTheme.subtitleTextStyle,
                ),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: Styles.normal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: Styles.tileTextPadding,
                            child: Text(
                              Strings.pressure,
                              style: ArnaTheme.of(context).textTheme.textStyle,
                            ),
                          ),
                          Padding(
                            padding: Styles.tileSubtitleTextPadding,
                            child: Text(
                              "${daily.pressure} hPa",
                              style: ArnaTheme.of(context)
                                  .textTheme
                                  .subtitleTextStyle
                                  .copyWith(
                                    color: ArnaDynamicColor.resolve(
                                      ArnaColors.secondaryTextColor,
                                      context,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: Styles.tileTextPadding,
                            child: Text(
                              Strings.humidity,
                              style: ArnaTheme.of(context).textTheme.textStyle,
                            ),
                          ),
                          Padding(
                            padding: Styles.tileSubtitleTextPadding,
                            child: Text(
                              "${daily.humidity}%",
                              style: ArnaTheme.of(context)
                                  .textTheme
                                  .subtitleTextStyle
                                  .copyWith(
                                    color: ArnaDynamicColor.resolve(
                                      ArnaColors.secondaryTextColor,
                                      context,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: Styles.normal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: Styles.tileTextPadding,
                            child: Text(
                              Strings.pop,
                              style: ArnaTheme.of(context).textTheme.textStyle,
                            ),
                          ),
                          Padding(
                            padding: Styles.tileSubtitleTextPadding,
                            child: Text(
                              "$pop%",
                              style: ArnaTheme.of(context)
                                  .textTheme
                                  .subtitleTextStyle
                                  .copyWith(
                                    color: ArnaDynamicColor.resolve(
                                      ArnaColors.secondaryTextColor,
                                      context,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: Styles.tileTextPadding,
                            child: Text(
                              Strings.uvi,
                              style: ArnaTheme.of(context).textTheme.textStyle,
                            ),
                          ),
                          Padding(
                            padding: Styles.tileSubtitleTextPadding,
                            child: Text(
                              "${daily.uvi!.toInt()}",
                              style: ArnaTheme.of(context)
                                  .textTheme
                                  .subtitleTextStyle
                                  .copyWith(
                                    color: ArnaDynamicColor.resolve(
                                      ArnaColors.secondaryTextColor,
                                      context,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
