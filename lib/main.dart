import 'package:arna/arna.dart';
import 'package:flutter/services.dart' show Brightness;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/database.dart';
import '/models/location.dart';
import '/providers/theme.dart';
import '/screens/main_page.dart';
import '/strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DatabaseAdapter());
  Hive.registerAdapter(LocationAdapter());
  await Hive.openBox<Database>(Strings.database);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(changeTheme);
    Brightness? brightness;

    switch (theme.theme) {
      case Theme.dark:
        brightness = Brightness.dark;
        break;
      case Theme.light:
        brightness = Brightness.light;
        break;
      default:
        brightness = null;
    }

    return ArnaApp(
      debugShowCheckedModeBanner: false,
      theme: ArnaThemeData(brightness: brightness),
      home: const MainPage(),
    );
  }
}
