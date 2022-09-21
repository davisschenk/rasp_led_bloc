import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rasp_led_bloc/config/routes/route_config.dart';
import 'package:rasp_led_bloc/config/routes/routes.dart';
import 'package:rasp_led_bloc/config/themes/themes.dart';
import 'package:rasp_led_bloc/core/settings/bloc/piip_bloc.dart';
import 'package:rasp_led_bloc/core/settings/cubit/piip_cubit.dart';
import 'package:rasp_led_bloc/core/settings/cubit/theme_cubit.dart';
import 'package:rasp_led_bloc/widgets/drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory());
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(
        create: (_) => PiipBloc(),
      )
    ], child: AppView());
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  _AppViewState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    RouterConfig.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, AppTheme>(builder: (context, theme) {
      return MaterialApp(
          theme: appThemeData[theme],
          onGenerateRoute: RouterConfig.router.generator,
          home: Body());
    });
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rasp LEDS")),
      drawer: drawer(context),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<PiipBloc, PiipState>(builder: (context, state) {
              if (state is PiipInitial) {
                return Text(state.uri.toString());
              } 
              if (state is PiipHasError) {
                return Text(state.error);
              }

              return Text("Other state");
            })
          ],
        ),
      ),
    );
  }
}
