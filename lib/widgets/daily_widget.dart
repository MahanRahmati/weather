import 'package:arna/arna.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '/models/daily.dart';
import '/strings.dart';

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
    return ArnaGroupedView(
      title: Strings.daily,
      children: daily.map((daily) {
        DateTime dt = daily!.date!;
        String date = DateFormat('d').format(dt);
        return ArnaListTile(
          leading: SizedBox(
            height: 42,
            width: 42,
            child: SvgPicture.asset(
              'assets/images/${daily.weatherIcon}.svg',
            ),
          ),
          title: (DateFormat('d').format(DateTime.now()) == date)
              ? Strings.today
              : DateFormat('EEEE').format(dt),
          subtitle: DateFormat('MMM d').format(dt),
          trailing: Row(
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
        );
      }).toList(),
    );
  }
}
