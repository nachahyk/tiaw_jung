import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:core_jung/core_jung.dart';

import 'package:tiaw_jung/src/routes/app_routes.dart';

/// Tiaw Jung's launch screen — its logo and name — shown briefly when the app
/// is opened from the switcher, then on to the trips page.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(AppDurations.splash, () {
      if (mounted) context.go(AppRoutes.trips);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MiniAppSplash(
      logo: AssetImage('assets/logo.png', package: 'tiaw_jung'),
      title: 'Tiaw Jung',
    );
  }
}
