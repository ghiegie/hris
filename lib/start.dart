import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hris/pages/empl_appl/empl_appl.dart';
import 'package:hris/pages/id_maker.dart';
import 'package:hris/pages/landing.dart';
import 'package:hris/pages/login.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "HRIS",

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent,
          brightness: Brightness.light
        )
      ),
      
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: "/",
            builder: _loginRouteBuilder,
            routes: [
              GoRoute(
                path: "landing",
                builder: _landingRouteBuilder,
                routes: [
                  GoRoute(
                    path: "empl_appl",
                    builder: _emplApplRouteBuilder
                  ),
                  GoRoute(
                    path: "id_maker",
                    builder: _idMakerRouteBuilder
                  ),
                ]
              )
            ]
          ),
        ]
      ),
    );
  }

  Widget _idMakerRouteBuilder(BuildContext buildContext, GoRouterState goRouterState) {
    return const IDMakerPage();
  }

  Widget _emplApplRouteBuilder(BuildContext buildContext, GoRouterState goRouterState) {
    return const EmployeeApplicationPage();
  }

  Widget _loginRouteBuilder(BuildContext buildContext, GoRouterState goRouterState) {
    return const LoginPage();
  }

  Widget _landingRouteBuilder(BuildContext buildContext, GoRouterState goRouterState) {
    return const LandingPage();
  }
}