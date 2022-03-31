import 'package:arna/arna.dart';

import '/models/database.dart';
import '/widgets/home_card_widget.dart';

class HomeGridWidget extends StatelessWidget {
  const HomeGridWidget({Key? key, required this.databases}) : super(key: key);

  final List<Database> databases;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isCompact(context)
            ? 1
            : isMedium(context)
                ? 2
                : 3,
        childAspectRatio: 2,
      ),
      itemCount: databases.length,
      padding: Styles.small,
      itemBuilder: (BuildContext context, int index) {
        return HomeCardWidget(database: databases[index]);
      },
    );
  }
}
