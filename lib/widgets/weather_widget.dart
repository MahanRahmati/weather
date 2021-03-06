import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/models/temperature.dart';
import '/providers/temp.dart';
import '/utils/functions.dart';

class WeatherWidget extends ConsumerWidget {
  const WeatherWidget({
    Key? key,
    required this.icon,
    required this.temperature,
    required this.description,
    required this.date,
    required this.timezoneOffset,
  }) : super(key: key);

  final String icon;
  final Temperature temperature;
  final String description;
  final DateTime date;
  final double timezoneOffset;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temp = ref.watch(changeTempUnit);
    return ArnaList(
      title: DateFormat('EEEE, d MMMM').format(
        date.add(
          Duration(seconds: timezoneOffset.toInt()),
        ),
      ),
      items: [
        Container(
          decoration: BoxDecoration(
            borderRadius: Styles.borderRadius,
            border: Border.all(
              color: ArnaDynamicColor.resolve(ArnaColors.borderColor, context),
            ),
            color: ArnaDynamicColor.resolve(ArnaColors.cardColor, context),
          ),
          child: Row(
            children: [
              Padding(
                padding: Styles.normal,
                child: Container(
                  height: 70,
                  width: 70,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: borderRadiusAll(70),
                    color: circleBackgroundColor(context),
                  ),
                  padding: Styles.normal,
                  child: SvgPicture.asset('assets/images/$icon.svg'),
                ),
              ),
              Padding(
                padding: Styles.normal,
                child: FittedBox(
                  child: Text(
                    description.toTitleCase(),
                    style: ArnaTheme.of(context).textTheme.titleTextStyle,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: Styles.normal,
                child: FittedBox(
                  child: Text(
                    temp.tempUnit == Temp.celsius
                        ? "${temperature.celsius!.ceil()}??"
                        : temp.tempUnit == Temp.fahrenheit
                            ? "${temperature.fahrenheit!.ceil()}??"
                            : "${temperature.kelvin!.ceil()}??",
                    style: ArnaTheme.of(context)
                        .textTheme
                        .largeTitleTextStyle
                        .copyWith(fontSize: 60),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
