import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gritstone_video_call/pages/home/home_widget.dart';
import 'package:gritstone_video_call/pages/login/login_widget.dart';
import 'package:gritstone_video_call/pages/sign_up/sign_up_widget.dart';
import 'package:gritstone_video_call/pages/splash_screen/splash_screen_widget.dart';
import 'package:gritstone_video_call/pages/video_call/video_call_widget.dart';
import '../constants/route_constants.dart';
import '../pages/welcome/welcome_widget.dart';

final GlobalKey<NavigatorState> rootNavigationKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> homeNavigationKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> chatNavigationKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> notificationsNavigationKey =
    GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> profileNavigationKey =
    GlobalKey<NavigatorState>();

class AppRoute {
  AppRoute._();

  static GoRouter routes = GoRouter(
      navigatorKey: rootNavigationKey,
      initialLocation: RoutePaths.root,
      routes: [
        GoRoute(
          path: RoutePaths.root,
          name: RouteNames.root,
          parentNavigatorKey: rootNavigationKey,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: RoutePaths.welcome,
          name: RouteNames.welcome,
          parentNavigatorKey: rootNavigationKey,
          builder: (context, state) => const WelcomePage(),
        ),
        GoRoute(
          path: RoutePaths.login,
          name: RouteNames.login,
          parentNavigatorKey: rootNavigationKey,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: RoutePaths.signUp,
          name: RouteNames.signUp,
          parentNavigatorKey: rootNavigationKey,
          builder: (context, state) => const SignUpPage(),
        ),
        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          parentNavigatorKey: rootNavigationKey,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: RoutePaths.videoCall,
          name: RouteNames.videoCall,
          parentNavigatorKey: rootNavigationKey,
          builder: (context, state) => const VideoCallPage(),
        ),
      ]);
}
