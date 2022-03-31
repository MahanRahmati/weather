import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/database.dart';
import '/models/forecast.dart';
import '/providers/temp.dart';
import '/screens/forecast_page.dart';
import '/strings.dart';
import '/utils/functions.dart';

class HomeCardWidget extends ConsumerStatefulWidget {
  const HomeCardWidget({Key? key, required this.database}) : super(key: key);

  final Database database;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeCardWidgetState();
}

class _HomeCardWidgetState extends ConsumerState<HomeCardWidget> {
  Box<Database>? db;

  @override
  void initState() {
    super.initState();
    db = Hive.box<Database>(Strings.database);
  }

  @override
  Widget build(BuildContext context) {
    final temp = ref.watch(changeTempUnit);
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: Styles.normal,
                            child: FittedBox(
                              child: Text(
                                temp.tempUnit == Temp.celsius
                                    ? forecast.temperature!.celsius!
                                            .ceil()
                                            .toString() +
                                        "°"
                                    : temp.tempUnit == Temp.fahrenheit
                                        ? forecast.temperature!.fahrenheit!
                                                .ceil()
                                                .toString() +
                                            "°"
                                        : forecast.temperature!.kelvin!
                                                .ceil()
                                                .toString() +
                                            "°",
                                style: ArnaTheme.of(context)
                                    .textTheme
                                    .largeTitleTextStyle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: Styles.normal,
                            child: FittedBox(
                              child: Text(
                                "${widget.database.location!.name}, ${widget.database.location!.country}",
                                style: ArnaTheme.of(context)
                                    .textTheme
                                    .subtitleTextStyle
                                    .copyWith(fontSize: 17),
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
