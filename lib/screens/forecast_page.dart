import 'package:arna/arna.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/database.dart';
import '/models/forecast.dart';
import '/models/location.dart';
import '/strings.dart';
import '/utils/functions.dart';
import '/widgets/daily_widget.dart';
import '/widgets/hourly_widget.dart';
import '/widgets/weather_widget.dart';

class ForecastPage extends StatefulWidget {
  final Location location;
  const ForecastPage({Key? key, required this.location}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  Box<Database>? db;

  @override
  void initState() {
    super.initState();
    db = Hive.box<Database>(Strings.database);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Forecast?>(
      future: forecastByLocation(db, widget.location),
      builder: (context, snapshot) {
        Forecast? forecast = snapshot.data;
        addToDatabase(db, forecast, widget.location);
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: ArnaProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Some error occurred! (${snapshot.hasError})",
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
                          icon: forecast.weatherIcon!,
                          temp:
                              forecast.temperature!.celsius!.ceil().toString(),
                          description: forecast.weatherDescription!,
                        ),
                      ),
                      HourlyWidget(
                        hourly: forecast.hourly!,
                        timezoneOffset: forecast.timezoneOffset!,
                      ),
                      DailyWidget(
                        daily: forecast.daily!,
                        timezoneOffset: forecast.timezoneOffset!,
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
