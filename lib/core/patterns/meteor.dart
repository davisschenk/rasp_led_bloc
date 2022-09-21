import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_api/led_api.dart';
import 'package:rasp_led_bloc/core/settings/bloc/piip_bloc.dart';
import 'dart:math' as math;

import 'package:rasp_led_bloc/widgets/color_selector.dart';

class MeteorPattern extends StatefulWidget {
  MeteorPattern({Key? key}) : super(key: key);

  @override
  _MeteorState createState() => _MeteorState();
}

class _MeteorState extends State<MeteorPattern> {
  Color color =
      Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  int tick_rate = 100;
  int decay = 128;
  int size = 16;
  bool random_decay = true;
  late LedClient client;

  void changeTickRate(int newTickRate) {
    setState(() {
      tick_rate = newTickRate;
    });
  }

  void changeDecay(int newDecay) {
    setState(() {
      decay = newDecay;
    });
  }

  void changeSize(int newSize) {
    setState(() {
      size = newSize;
    });
  }

  void changeRandomDecay(bool newRandomDecay) {
    setState(() {
      random_decay = newRandomDecay;
    });
  }

  void changeColor(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  Map<String, dynamic> getData() {
    return {
      "pattern": "meteor",
      "tick_rate": (1000 / tick_rate).floor(),
      "color": [color.blue, color.green, color.red, 0],
      "random_decay": random_decay,
      "decay": decay,
      "size": size
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meteor"),
      ),
      body: Center(
          child: Column(children: [
        ListTile(
            title: Text("Meteor Color"),
            trailing: ColorSelector(color, changeColor)),
        ListTile(
          title: Text("Tick Rate"),
          subtitle: Slider(
            onChanged: (tr) => changeTickRate(tr.toInt()),
            value: tick_rate.toDouble(),
            min: 1,
            max: 255,
          ),
          trailing: Padding(
              padding: const EdgeInsets.only(right: 12),
              child:
                  Column(children: [Text(tick_rate.toString()), Text("TPS")])),
        ),
        ListTile(
          title: Text("Decay"),
          subtitle: Slider(
            onChanged: (tr) => changeDecay(tr.toInt()),
            value: decay.toDouble(),
            min: 1,
            max: 255,
          ),
          trailing: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: [Text(decay.toString()), Text("255")],
              )),
        ),
        ListTile(
          title: Text("Meteor Size"),
          subtitle: Slider(
            onChanged: (tr) => changeSize(tr.toInt()),
            value: size.toDouble(),
            min: 1,
            max: 255,
          ),
          trailing: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text(size.toString()), Text("PXL")])),
        ),
        SwitchListTile(
            title: Text("Random Decay"),
            value: random_decay,
            onChanged: changeRandomDecay),
        BlocBuilder<PiipBloc, PiipState>(builder: (context, state) {
          return ElevatedButton(
              child: Text("Submit"),
              onPressed: () => {
                    if (state is PiipInitial)
                      {
                        client = LedClient(state.uri.toString()),
                        client.sendMessage(Meteor(
                          tickRate: (1000 / tick_rate).floor(),
                          color: [color.blue, color.green, color.red, 0],
                          randomDecay: random_decay,
                          decay: decay,
                          size: size
                        ))
                      }
                  });
        })
      ])),
    );
  }
}