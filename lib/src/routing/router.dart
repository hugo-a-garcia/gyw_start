import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gyw_start/src/settings/settings_controller.dart';
import 'package:gyw_start/src/settings/settings_view.dart';
import 'package:gyw_start/src/ui/feature_a/feature_a_screen.dart';
import 'package:gyw_start/src/ui/feature_b/feature_b_screen.dart';
import 'package:gyw_start/src/ui/feature_c/feture_c_screen.dart';

import '../ui/home/widgets/home_screen.dart';
import 'routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

GoRouter router(SettingsController settingsController) => GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/a',
      debugLogDiagnostics: true,
      routes: <RouteBase>[
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return HomeScreen(child: child);
          },
          routes: <RouteBase>[
            /// The first screen to display in the bottom navigation bar.
            GoRoute(
              path: '/a',
              builder: (BuildContext context, GoRouterState state) {
                return const FeatureAScreenA();
              },
              // routes: <RouteBase>[
              //   // The details screen to display stacked on the inner Navigator.
              //   // This will cover screen A but not the application shell.
              //   GoRoute(
              //     path: 'details',
              //     builder: (BuildContext context, GoRouterState state) {
              //       return const DetailsScreen(label: 'A');
              //     },
              //   ),
              // ],
            ),

            /// Displayed when the second item in the the bottom navigation bar is
            /// selected.
            GoRoute(
              path: '/b',
              builder: (BuildContext context, GoRouterState state) {
                return const FeatureBScreenB();
              },
              // routes: <RouteBase>[
              //   /// Same as "/a/details", but displayed on the root Navigator by
              //   /// specifying [parentNavigatorKey]. This will cover both screen B
              //   /// and the application shell.
              //   GoRoute(
              //     path: 'details',
              //     parentNavigatorKey: _rootNavigatorKey,
              //     builder: (BuildContext context, GoRouterState state) {
              //       return const DetailsScreen(label: 'B');
              //     },
              //   ),
              // ],
            ),

            /// The third screen to display in the bottom navigation bar.
            GoRoute(
              path: '/c',
              builder: (BuildContext context, GoRouterState state) {
                return const FeatureCScreenC();
              },
              // routes: <RouteBase>[
              //   // The details screen to display stacked on the inner Navigator.
              //   // This will cover screen C but not the application shell.
              //   GoRoute(
              //     path: 'details',
              //     builder: (BuildContext context, GoRouterState state) {
              //       return const DetailsScreen(label: 'C');
              //     },
              //   ),
              // ],
            ),
            // GoRoute(
            //   path: '/',
            //   builder: (context, state) => FeatureAScreenA(),
            //   routes: [
            //     GoRoute(
            //       path: '/settings',
            //       builder: (context, state) =>
            //           SettingsView(controller: settingsController),
            //     ),
            //   ],
            // ),
          ],
        ),
      ],
    );
