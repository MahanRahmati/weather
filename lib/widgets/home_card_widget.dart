import 'package:arna/arna.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/database.dart';
import '/models/forecast.dart';
import '/screens/forecast_page.dart';
import '/strings.dart';
import '/utils/functions.dart';

class HomeCardWidget extends StatefulWidget {
  const HomeCardWidget({Key? key, required this.database}) : super(key: key);

  final Database database;

  @override
  State<HomeCardWidget> createState() => _HomeCardWidgetState();
}

class _HomeCardWidgetState extends State<HomeCardWidget> {
  Box<Database>? db;

  @override
  void initState() {
    super.initState();
    db = Hive.box<Database>(Strings.database);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Forecast?>(
      future: forecastByLocation(db, widget.database.location!),
      builder: (context, snapshot) {
        Forecast? forecast = snapshot.data;
        addToDatabase(db, forecast, widget.database.location!);
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
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    ArnaPageRoute(
                      builder: (context) =>
                          ForecastPage(location: widget.database.location!),
                    ),
                  ),
                  child: ArnaCard(
                    child: Padding(
                      padding: Styles.normal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: Styles.normal,
                                child: FittedBox(
                                  child: Text(
                                    widget.database.location!.name,
                                    style: ArnaTheme.of(context)
                                        .textTheme
                                        .titleTextStyle,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: Styles.normal,
                                child: FittedBox(
                                  child: Text(
                                    widget.database.location!.country,
                                    style: ArnaTheme.of(context)
                                        .textTheme
                                        .subtitleTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: Styles.normal,
                            child: FittedBox(
                              child: Text(
                                forecast.temperature!.celsius!
                                        .ceil()
                                        .toString() +
                                    "°C",
                                style: ArnaTheme.of(context)
                                    .textTheme
                                    .titleTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
