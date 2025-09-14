import 'package:ayana_space_app/features/homepage/home_page.dart';
import 'package:go_router/go_router.dart';

class HomePageRoute {
  static GoRoute get route => GoRoute(
        path: '/',
        builder: (context, state) => HomePage(),
      );
}
