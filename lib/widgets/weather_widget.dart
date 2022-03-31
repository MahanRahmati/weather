import 'package:arna/arna.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/utils/functions.dart';

class WeatherWidget extends StatelessWidget {
  final String icon;
  final String temp;
  final String description;

  const WeatherWidget({
    Key? key,
    required this.icon,
    required this.temp,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.normal,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 98,
            width: 98,
            child: SvgPicture.asset('assets/images/$icon.svg'),
          ),
          Padding(
            padding: Styles.normal,
            child: FittedBox(
              child: Text(
                temp + "°C",
                style: ArnaTheme.of(context)
                    .textTheme
                    .largeTitleTextStyle
                    .copyWith(fontSize: 60),
              ),
            ),
          ),
          Padding(
            padding: Styles.normal,
            child: FittedBox(
              child: Text(
                description.toTitleCase(),
                style: ArnaTheme.of(context)
                    .textTheme
                    .subtitleTextStyle
                    .copyWith(fontSize: 17),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
