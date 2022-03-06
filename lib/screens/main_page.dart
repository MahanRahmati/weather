import 'package:arna/arna.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  bool loading = true;
  var showSearch = false;
  TextEditingController controller = TextEditingController();

  void refresh(Location? location) async {
    setState(() => loading = false); //TODO Add refresh
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
    );
  }

  List<MasterNavigationItem> masterBuilder() {
    List<MasterNavigationItem> items = [];
    items.addAll(
      savedLocations.map(
        (location) => MasterNavigationItem(
          leading: const Icon(
            Icons.location_city_outlined,
            size: Styles.iconSize,
          ),
          title: location.name,
          subtitle: location.country,
          headerBarTrailing: ArnaIconButton(
            icon: Icons.refresh_outlined,
            onPressed: () {
              setState(() => loading = true);
              refresh(
                Location(
                  name: location.name,
                  country: location.country,
                  lat: location.lat,
                  lon: location.lon,
                ),
              );
            },
          ),
          builder: (context) => ForecastPage(
            location: Location(
              name: location.name,
              country: location.country,
              lat: location.lat,
              lon: location.lon,
            ),
          ),
        ),
      ),
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return savedLocations.isEmpty
        ? ArnaScaffold(
            headerBarLeading: ArnaIconButton(
              icon: Icons.search_outlined,
              onPressed: () => setState(() {
                locations.clear();
                showSearch = !showSearch;
                controller.text = "";
              }),
            ),
            title: Strings.places,
            headerBarTrailing: Row(
              children: [
                ArnaIconButton(
                  icon: Icons.info_outlined,
                  onPressed: () {},
                ),
                ArnaIconButton(
                  icon: Icons.settings_outlined,
                  onPressed: () => showArnaPopupDialog(
                    context: context,
                    title: Strings.settings,
                    body: const SettingsPage(),
                  ),
                ),
              ],
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
            body: Column(
              children: [
                showSearch
                    ? SingleChildScrollView(
                        child: ArnaGroupedView(
                          title: "Locations",
                          children: locations
                              .map(
                                (location) => ArnaListTile(
                                  onTap: () => setState(
                                    () => savedLocations.add(location),
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
                      )
                    : const Expanded(child: WelcomeWidget()),
              ],
            ),
          )
        : ArnaMasterDetailScaffold(
            items: masterBuilder(),
            headerBarTrailing: Row(
              children: [
                ArnaIconButton(
                  icon: Icons.info_outlined,
                  onPressed: () {},
                ),
                ArnaIconButton(
                  icon: Icons.settings_outlined,
                  onPressed: () => showArnaPopupDialog(
                    context: context,
                    title: Strings.settings,
                    body: const SettingsPage(),
                  ),
                ),
              ],
            ),
            title: Strings.places,
            currentIndex: 0,
            emptyBody: const WelcomeWidget(),
          );
  }
}
