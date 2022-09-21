import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:rasp_led_bloc/core/patterns/alternating.dart';
import 'package:rasp_led_bloc/core/patterns/meteor.dart';
import 'package:rasp_led_bloc/core/patterns/solid.dart';
import 'package:rasp_led_bloc/core/settings/settings.dart';

class Routes {
  static var settings = Handler(handlerFunc: (context, _) {
    return SettingsScreen();
  });


  static void configureRoutes(FluroRouter router) {
    router.define("/settings", handler: settings);
    router.define("/pattern/solid", handler: Handler(handlerFunc: (context, _) => SolidPattern()));
    router.define("/pattern/meteor", handler: Handler(handlerFunc: (context, _) => MeteorPattern()));
    router.define("/pattern/rainbow", handler: Handler(handlerFunc: (context, _) => MeteorPattern()));
    router.define("/pattern/alternating", handler: Handler(handlerFunc: (context, _) => AlternatingPattern()));


  }
}
