import 'package:arna/arna.dart';

import '/strings.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: Styles.large,
          child: ClipRRect(
            borderRadius: borderRadiusAll(Styles.largePadding),
            child: const Image(
              height: 175,
              image: AssetImage('assets/images/icon.png'),
            ),
          ),
        ),
        Padding(
          padding: Styles.large,
          child: Text(
            Strings.welcome,
            style: ArnaTheme.of(context).textTheme.largeTitleTextStyle,
          ),
        ),
        Padding(
          padding: Styles.large,
          child: Text(
            Strings.emptyLocation,
            style: ArnaTheme.of(context).textTheme.titleTextStyle,
          ),
        ),
      ],
    );
  }
}
