import 'package:arna/arna.dart';

import '/strings.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
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
  Widget build(BuildContext context) {
    return ArnaGroupedView(
      title: Strings.details,
      children: [
        ArnaListTile(
          leading: const Icon(Icons.speed_outlined),
          title: Strings.pressure,
          subtitle: "$pressure hPa",
        ),
        ArnaListTile(
          leading: const Icon(Icons.opacity_outlined),
          title: Strings.humidity,
          subtitle: "$humidity%",
        ),
        ArnaListTile(
          leading: const Icon(Icons.air_outlined),
          title: Strings.windSpeed,
          subtitle: "$windSpeed m/s",
        ),
        ArnaListTile(
          leading: const Icon(Icons.brightness_high_outlined),
          title: Strings.uvi,
          subtitle: "${uvi.toInt()}",
        ),
        ArnaListTile(
          leading: const Icon(Icons.cloud_outlined),
          title: Strings.clouds,
          subtitle: "${(clouds * 100).toInt()}%",
        ),
        ArnaListTile(
          leading: const Icon(Icons.visibility_outlined),
          title: Strings.visibility,
          subtitle: "$visibility m",
        ),
      ],
    );
  }
}
