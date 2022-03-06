import 'package:arna/arna.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/strings.dart';

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
    return ArnaList(
      title: Strings.today,
      items: [
        Padding(
          padding: Styles.normal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: Styles.normal,
                child: SizedBox(
                  height: 98,
                  width: 98,
                  child: SvgPicture.asset(
                    'assets/images/$icon.svg',
                    height: 98,
                    width: 98,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: Styles.normal,
                    child: FittedBox(
                      child: Text(
                        temp + "°C",
                        style: ArnaTheme.of(context).textTheme.titleTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: Styles.normal,
                    child: FittedBox(
                      child: Text(
                        description,
                        style: ArnaTheme.of(context).textTheme.titleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
