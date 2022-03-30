import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/database.dart';
import '/models/location.dart';
import '/screens/forecast_page.dart';
import '/screens/settings_page.dart';
import '/strings.dart';
import '/utils/functions.dart';
import '/widgets/welcome_widget.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  List<Location> savedLocations = [];
  List<Location> locations = [];
  var showSearch = true;
  TextEditingController controller = TextEditingController();
  Box<Database>? db;

  @override
  void initState() {
    super.initState();
    db = Hive.box<Database>(Strings.database);
    _updateItems();
  }

  _updateItems() async {
    List<int>? keys = db!.keys.cast<int>().toList();
    if (keys.isNotEmpty) {
      for (int i = 0; i < keys.length; i++) {
        int key = keys[i];
        final Database? database = db!.get(key);
        if (database != null) {
          if (database.location != null) {
            savedLocations.add(database.location!);
          }
        }
      }
    }
  }

  Future search(String query) async {
    List<Location> searchLocations = await searchLocation(query);
    locations.clear();
    setState(
      () => locations.addAll(
        searchLocations
            .map(
              (location) => Location(
                name: location.name,
                country: location.country,
                lat: location.lat,
                lon: location.lon,
              ),
            )
            .toList(),
      ),
    ); //TODO Fix Stateful dialog
  }

  @override
  Widget build(BuildContext context) {
    return ArnaScaffold(
      headerBarLeading: ArnaIconButton(
        icon: savedLocations.isEmpty
            ? Icons.add_outlined
            : Icons.location_city_outlined,
        onPressed: () => showArnaPopupDialog(
          context: context,
          title: Strings.places,
          headerBarLeading: ArnaIconButton(
            icon: Icons.search_outlined,
            onPressed: () => setState(() {
              locations.clear();
              showSearch = !showSearch;
              controller.text = "";
            }),
          ),
          searchField: ArnaSearchField(
            showSearch: showSearch,
            controller: controller,
            onChanged: (text) {
              if (text.isNotEmpty && text.length > 3) search(text);
            },
            onSubmitted: (text) {
              if (text.isNotEmpty) search(text);
            },
          ),
          body: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: ArnaGroupedView(
                  title: "Locations",
                  children: locations
                      .map(
                        (location) => ArnaListTile(
                          onTap: () => setState(
                            () {
                              savedLocations.add(location);
                              locations.clear();
                              showSearch = !showSearch;
                              controller.text = "";
                            },
                          ),
                          leading: const Icon(
                            Icons.location_city_outlined,
                            size: Styles.iconSize,
                          ),
                          title: location.name,
                          subtitle: location.country,
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ),
      ),
      title: Strings.places,
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
      body: savedLocations.isEmpty
          ? const WelcomeWidget()
          : ForecastPage(
              location: Location(
                name: savedLocations[0].name,
                country: savedLocations[0].country,
                lat: savedLocations[0].lat,
                lon: savedLocations[0].lon,
              ), //TODO Fix current item
            ),
    );
  }
}
