import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/strings.dart';
import '/utils/functions.dart';

class CurrentWidget extends ConsumerWidget {
  const CurrentWidget({
    Key? key,
    required this.pressure,
    required this.humidity,
    required this.uvi,
    required this.windSpeed,
    required this.clouds,
    required this.visibility,
  }) : super(key: key);

  final double pressure;
  final double humidity;
  final double uvi;
  final double windSpeed;
  final double clouds;
  final double visibility;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ArnaList(
      title: Strings.details,
      items: [
        Padding(
          padding: Styles.normal,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: Styles.borderRadius,
              border: Border.all(
                color: ArnaDynamicColor.resolve(
                  ArnaColors.borderColor,
                  context,
                ),
              ),
              color: ArnaDynamicColor.resolve(ArnaColors.cardColor, context),
            ),
            child: Column(
              children: [
                rowBuilder(
                  [
                    columnBuilder(context, Strings.pressure, "$pressure hPa"),
                    columnBuilder(context, Strings.humidity, "$humidity%"),
                  ],
                ),
                rowBuilder(
                  [
                    columnBuilder(context, Strings.windSpeed, "$windSpeed m/s"),
                    columnBuilder(context, Strings.uvi, "${uvi.toInt()}"),
                  ],
                ),
                rowBuilder(
                  [
                    columnBuilder(
                      context,
                      Strings.clouds,
                      "${(clouds * 100).toInt()}%",
                    ),
                    columnBuilder(context, Strings.visibility, "$visibility m"),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
