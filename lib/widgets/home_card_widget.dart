import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                      builder: (context) => ForecastPage(
                        location: widget.database.location!,
                      ),
                    ),
                  ),
                  child: ArnaCard(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: Styles.borderRadius,
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: backgroundColor(
                            forecast.date!,
                            forecast.timezoneOffset!,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: Styles.padding),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: Styles.normal,
                                  child: FittedBox(
                                    child: Text(
                                      temp.tempUnit == Temp.celsius
                                          ? "${forecast.temperature!.celsius!.ceil()}°"
                                          : temp.tempUnit == Temp.fahrenheit
                                              ? "${forecast.temperature!.fahrenheit!.ceil()}°"
                                              : "${forecast.temperature!.kelvin!.ceil()}°",
                                      style: ArnaTheme.of(context)
                                          .textTheme
                                          .largeTitleTextStyle
                                          .copyWith(
                                            fontSize: 42,
                                            color: ArnaColors
                                                .reversePrimaryTextColor,
                                          ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: Styles.tileTextPadding,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          widget.database.location!.name,
                                          style: ArnaTheme.of(context)
                                              .textTheme
                                              .titleTextStyle
                                              .copyWith(
                                                color: ArnaColors
                                                    .reversePrimaryTextColor,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: Styles.large,
                            child: Container(
                              height: 70,
                              width: 70,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: borderRadiusAll(70),
                                color: circleBackgroundColor(context),
                              ),
                              padding: Styles.normal,
                              child: SvgPicture.asset(
                                'assets/images/${forecast.weatherIcon!}.svg',
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
