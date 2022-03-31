import 'package:arna/arna.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/database.dart';
import '/models/location.dart';
import '/screens/add_page.dart';
import '/screens/settings_page.dart';
import '/strings.dart';
import '/widgets/home_grid_widget.dart';
import '/widgets/welcome_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Box<Database>? db;
  List<Location> locations = [];
  List<Location> filteredLocations = [];
  var showSearch = false;
  TextEditingController controller = TextEditingController();

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
            locations.add(database.location!);
          }
        }
      }
    }
  }

  Future search(String query) async {
    if (query.isEmpty) {
      setState(() {});
      return;
    }
    if (query.isNotEmpty) {
      filteredLocations.clear();
      for (Location location in locations) {
        if (location.name.toLowerCase().contains(query.toLowerCase()) ||
            location.country.toLowerCase().contains(query.toLowerCase())) {
          filteredLocations.add(location);
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ArnaScaffold(
      headerBarLeading: ArnaIconButton(
        icon: Icons.add_outlined,
        onPressed: () => Navigator.push(
          context,
          ArnaPageRoute(builder: (context) => const AddPage()),
        ),
      ),
      title: Strings.appName,
      actions: [
        ArnaIconButton(
          icon: Icons.search_outlined,
          onPressed: () => setState(() => showSearch = !showSearch),
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
      searchField: ArnaSearchField(
        showSearch: showSearch,
        controller: controller,
        onChanged: (text) => search(text),
        placeholder: Strings.search,
      ),
      body: locations.isEmpty
          ? const WelcomeWidget()
          : controller.text.isEmpty
              ? HomeGridWidget(locations: locations)
              : HomeGridWidget(locations: filteredLocations),
    );
  }
}
