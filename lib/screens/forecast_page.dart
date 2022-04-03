import 'package:arna/arna.dart';
import 'package:flutter/material.dart' show MaterialLocalizations;
import 'package:hive_flutter/hive_flutter.dart';

import '/models/database.dart';
import '/models/forecast.dart';
import '/models/location.dart';
import '/screens/settings_page.dart';
import '/strings.dart';
import '/utils/functions.dart';
import '/widgets/daily_widget.dart';
import '/widgets/details_widget.dart';
import '/widgets/today_widget.dart';
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
    return ArnaScaffold(
      headerBarLeading: ArnaIconButton(
        icon: Icons.arrow_back_outlined,
        onPressed: () => Navigator.pop(context),
        tooltipMessage: MaterialLocalizations.of(context).backButtonTooltip,
        semanticLabel: MaterialLocalizations.of(context).backButtonTooltip,
      ),
      title: widget.location.name,
      actions: [
        ArnaIconButton(
          icon: Icons.settings_outlined,
          onPressed: () => showArnaPopupDialog(
            context: context,
            title: Strings.settings,
            body: const SettingsPage(),
          ),
        ),
      ],
      body: FutureBuilder<Forecast?>(
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
                  Widget weatherWidget = WeatherWidget(
                    icon: forecast.weatherIcon!,
                    temperature: forecast.temperature!,
                    description: forecast.weatherDescription!,
                    date: forecast.date!,
                  );
                  Widget detailsWidget = DetailsWidget(
                    pressure: forecast.pressure!,
                    humidity: forecast.humidity!,
                    uvi: forecast.uvi!,
                    windSpeed: forecast.windSpeed!,
                    clouds: forecast.clouds!,
                    visibility: forecast.visibility!,
                  );
                  Widget todayWidget = TodayWidget(
                    hourly: forecast.hourly!,
                    timezoneOffset: forecast.timezoneOffset!,
                  );
                  Widget dailyWidget = DailyWidget(
                    daily: forecast.daily!,
                    timezoneOffset: forecast.timezoneOffset!,
                  );
                  return isExpanded(context)
                      ? SingleChildScrollView(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: deviceWidth(context) / 2,
                                child: Column(
                                  children: [
                                    weatherWidget,
                                    detailsWidget,
                                    todayWidget,
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: deviceWidth(context) / 2,
                                child: dailyWidget,
                              ),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              weatherWidget,
                              detailsWidget,
                              todayWidget,
                              dailyWidget,
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
      ),
    );
  }
}
