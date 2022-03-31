import 'package:arna/arna.dart';

import '/models/location.dart';
import '/widgets/home_card_widget.dart';

class HomeGridWidget extends StatelessWidget {
  const HomeGridWidget({Key? key, required this.locations}) : super(key: key);

  final List<Location> locations;

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
      itemCount: locations.length,
      padding: Styles.small,
      itemBuilder: (BuildContext context, int index) {
        return HomeCardWidget(location: locations[index]);
      },
    );
  }
}
