import 'package:arna/arna.dart';

import '/models/forecast.dart';
import '/models/location.dart';
import '/utils/functions.dart';
import '/widgets/daily_widget.dart';
import '/widgets/details_widget.dart';
import '/widgets/hourly_widget.dart';
import '/widgets/weather_widget.dart';

class ForecastPage extends StatelessWidget {
  final Location location;
  const ForecastPage({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Forecast?>(
      future: getForecast(location),
      builder: (context, snapshot) {
        Forecast? forecast = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: ArnaProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Some error occurred! (snapshot.hasError)",
                  style: ArnaTheme.of(context).textTheme.textStyle,
                ),
              );
            } else {
              if (forecast != null) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: Styles.padding),
                        child: WeatherWidget(
                          icon: forecast.current.weather[0].icon,
                          temp: forecast.current.temp.ceil().toString(),
                          description: forecast.current.weather[0].description,
                        ),
                      ),
                      DetailsWidget(current: forecast.current),
                      HourlyWidget(
                        hourly: forecast.hourly,
                        timezoneOffset: forecast.timezoneOffset,
                      ),
                      DailyWidget(
                        daily: forecast.daily,
                        timezoneOffset: forecast.timezoneOffset,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "Some error occurred! (forecast = null)",
                    style: ArnaTheme.of(context).textTheme.textStyle,
                  ),
                );
              }
            }
        }
      },
    );
  }
}
