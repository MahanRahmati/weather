import 'package:arna/arna.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/database.dart';
import '/screens/add_page.dart';
import '/screens/settings_page.dart';
import '/strings.dart';
import '/utils/functions.dart';
import '/widgets/home_grid_widget.dart';
import '/widgets/welcome_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Box<Database>? db;
  List<Database> databases = [];
  List<Database> filteredDatabases = [];
  var showSearch = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = Hive.box<Database>(Strings.database);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future search(String query) async {
    if (query.isEmpty) {
      setState(() {});
      return;
    }
    if (query.isNotEmpty) {
      filteredDatabases.clear();
      for (Database database in databases) {
        if (database.location!.name
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            database.location!.country
                .toLowerCase()
                .contains(query.toLowerCase())) {
          filteredDatabases.add(database);
        }
        setState(() {});
      }
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
        tooltipMessage: Strings.add,
      ),
      title: Strings.appName,
      actions: [
        ArnaIconButton(
          icon: Icons.search_outlined,
          onPressed: () => setState(() => showSearch = !showSearch),
          tooltipMessage: Strings.searchTooltip,
        ),
        ArnaIconButton(
          icon: Icons.settings_outlined,
          onPressed: () => showArnaPopupDialog(
            context: context,
            title: Strings.settings,
            body: const SettingsPage(),
          ),
          tooltipMessage: Strings.settings,
        ),
      ],
      searchField: ArnaSearchField(
        showSearch: showSearch,
        controller: controller,
        onChanged: (text) => search(text),
        placeholder: Strings.search,
      ),
      body: FutureBuilder<List<Database>>(
        future: updateItems(db),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null) databases.addAll(snapshot.data!);
            return databases.isEmpty
                ? const WelcomeWidget()
                : controller.text.isEmpty
                    ? HomeGridWidget(databases: databases)
                    : HomeGridWidget(databases: filteredDatabases);
          }
          return const WelcomeWidget();
        },
      ),
    );
  }
}
