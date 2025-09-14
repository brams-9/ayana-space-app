import 'package:ayana_space_app/cores/routing/route_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) =>
  //       const MyHomePage(title: 'Ayana Space App'),
  // ),
  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        ShellRoute(
          builder: (context, state, child) => child,
          routes: RoutesList.routes,
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: false,
      ),
    );
  }
}
