import 'package:arna/arna.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/utils/functions.dart';

class WeatherWidget extends StatelessWidget {
  final String icon;
  final String description;
  final DateTime date;

  const WeatherWidget({
    Key? key,
    required this.icon,
    required this.description,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Styles.largePadding + Styles.padding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Styles.borderRadius,
          border: Border.all(
            color: ArnaDynamicColor.resolve(ArnaColors.borderColor, context),
          ),
          color: ArnaDynamicColor.resolve(ArnaColors.cardColor, context),
        ),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Padding(
              padding: Styles.normal,
              child: Container(
                height: 98,
                width: 98,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: borderRadiusAll(98),
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
            Padding(
              padding: Styles.normal,
              child: FittedBox(
                child: Text(
                  DateFormat('EEEE, d MMMM').format(date),
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
            ),
            const SizedBox(height: Styles.padding),
          ],
        ),
      ),
    );
  }
}
