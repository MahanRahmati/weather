import 'package:arna/arna.dart';
import 'package:flutter/material.dart' show MaterialLocalizations;

import '/models/location.dart';
import '/screens/forecast_page.dart';
import '/strings.dart';
import '/utils/functions.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  List<Location> locations = [];
  var showSearch = true;
  TextEditingController controller = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return ArnaScaffold(
      headerBarLeading: ArnaIconButton(
        icon: Icons.arrow_back_outlined,
        onPressed: () => Navigator.pop(context),
        tooltipMessage: MaterialLocalizations.of(context).backButtonTooltip,
        semanticLabel: MaterialLocalizations.of(context).backButtonTooltip,
      ),
      title: Strings.places,
      actions: [
        ArnaIconButton(
          icon: Icons.search_outlined,
          onPressed: () => setState(() {
            locations.clear();
            showSearch = !showSearch;
            controller.text = "";
          }),
        )
      ],
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
      body: SingleChildScrollView(
        child: ArnaGroupedView(
          title: "Locations",
          children: locations
              .map(
                (location) => ArnaListTile(
                  onTap: () => setState(
                    () => Navigator.pushReplacement(
                      context,
                      ArnaPageRoute(
                        builder: (context) => ForecastPage(
                          location: location,
                        ),
                      ),
                    ),
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
      ),
    );
  }
}
