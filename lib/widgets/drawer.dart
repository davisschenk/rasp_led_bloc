import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_api/led_api.dart';
import 'package:rasp_led_bloc/config/routes/route_config.dart';
import 'package:rasp_led_bloc/core/settings/bloc/piip_bloc.dart';


var drawer = (context) =>  Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor
              ),
              child: Column(children: [Text("Control Menu"), 
              BlocBuilder<PiipBloc, PiipState>(builder: (context, state) {
                return ElevatedButton.icon(onPressed: () => {
                      if (state is PiipInitial) {
                        LedClient(state.uri.toString()).sendMessage(Power("toggle"))
                      }
                }, icon: Icon(Icons.power), label: Text("Power"));})])),
            ExpansionTile(
              title: Text("Patterns"),
              children: [
                ListTile(
                  title: Text("Solid"),
                  onTap: () => RouterConfig.router.navigateTo(context, "/pattern/solid"),
                ),
                                ListTile(
                  title: Text("Meteor"),
                  onTap: () => RouterConfig.router.navigateTo(context, "/pattern/meteor"),
                ),
                ListTile(
                  title: Text("Rainbow"),
                  onTap: () => RouterConfig.router.navigateTo(context, "/pattern/rainbow"),
                ),
                ListTile(
                  title: Text("Alternating"),
                  onTap: () => RouterConfig.router.navigateTo(context, "/pattern/alternating"),
                )
              ],
            ),
            
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () => RouterConfig.router.navigateTo(context, "/settings"),
            )
          ],
        ),
      );