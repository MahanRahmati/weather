import 'package:arna/arna.dart';

import '/models/location.dart';
import '/screens/forecast_page.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({Key? key, required this.location}) : super(key: key);

  final Location location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        ArnaPageRoute(
          builder: (context) => ForecastPage(location: location),
        ),
      ),
      child: ArnaCard(
        child: Padding(
          padding: Styles.normal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: Styles.tileTextPadding,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        location.name,
                        style: ArnaTheme.of(context).textTheme.textStyle,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: Styles.tileSubtitleTextPadding,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        location.country,
                        style:
                            ArnaTheme.of(context).textTheme.subtitleTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
