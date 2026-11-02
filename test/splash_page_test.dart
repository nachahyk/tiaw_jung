import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:core_jung/core_jung.dart';

import 'package:tiaw_jung/src/features/splash/presentation/pages/splash_page.dart';

void main() {
  testWidgets('shows the Tiaw Jung logo, then moves on to the app', (tester) async {
    final router = GoRouter(
      initialLocation: '/tiaw-jung',
      routes: [
        GoRoute(path: '/tiaw-jung', builder: (_, _) => const SplashPage()),
        GoRoute(path: '/tiaw-jung/trips', builder: (_, _) => const Text('landed')),
      ],
    );
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pump();

    final splash = tester.widget<MiniAppSplash>(find.byType(MiniAppSplash));
    expect(splash.title, 'Tiaw Jung');
    expect((splash.logo as AssetImage).keyName, 'packages/tiaw_jung/assets/logo.png');
    expect(find.text('landed'), findsNothing);

    await tester.pump(AppDurations.splash);
    await tester.pumpAndSettle();
    expect(find.text('landed'), findsOneWidget);
  });
}
