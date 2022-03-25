import 'package:arna/arna.dart';
import 'package:flutter/services.dart' show Brightness;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/screens/main_page.dart';
import '/screens/settings_page.dart';
import '/utils/functions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    fetchData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
