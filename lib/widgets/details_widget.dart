import 'package:arna/arna.dart';
import 'package:weather/models/current.dart';

import '/strings.dart';

class DetailsWidget extends StatelessWidget {
  final Current? current;

  const DetailsWidget({Key? key, required this.current}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Styles.normal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ArnaCard(
            child: Column(
              children: [
                Padding(
                  padding: Styles.normal,
                  child: Text(
                    Strings.wind,
                    style: ArnaTheme.of(context).textTheme.subtitleTextStyle,
                  ),
                ),
                Padding(
                  padding: Styles.normal,
                  child: Text(
                    "${current!.windSpeed.ceil()}",
                    style: ArnaTheme.of(context).textTheme.titleTextStyle,
                  ),
                ),
              ],
            ),
          ),
          ArnaCard(
            child: Column(
              children: [
                Padding(
                  padding: Styles.normal,
                  child: Text(
                    Strings.humidity,
                    style: ArnaTheme.of(context).textTheme.subtitleTextStyle,
                  ),
                ),
                Padding(
                  padding: Styles.normal,
                  child: Text(
                    current!.humidity.ceil().toString(),
                    style: ArnaTheme.of(context).textTheme.titleTextStyle,
                  ),
                ),
              ],
            ),
          ),
          ArnaCard(
            child: Column(
              children: [
                Padding(
                  padding: Styles.normal,
                  child: Text(
                    Strings.uv,
                    style: ArnaTheme.of(context).textTheme.subtitleTextStyle,
                  ),
                ),
                Padding(
                  padding: Styles.normal,
                  child: Text(
                    current!.uvi.ceil().toString(),
                    style: ArnaTheme.of(context).textTheme.titleTextStyle,
                  ),
                ),
              ],
            ),
          ),
          ArnaCard(
            child: Column(
              children: [
                Padding(
                  padding: Styles.normal,
                  child: Text(
                    Strings.pressure,
                    style: ArnaTheme.of(context).textTheme.subtitleTextStyle,
                  ),
                ),
                Padding(
                  padding: Styles.normal,
                  child: Text(
                    current!.pressure.ceil().toString(),
                    style: ArnaTheme.of(context).textTheme.titleTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
