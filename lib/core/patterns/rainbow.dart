import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_api/led_api.dart';
import 'package:rasp_led_bloc/core/settings/bloc/piip_bloc.dart';
import 'package:rasp_led_bloc/widgets/color_selector.dart';

class RainbowPattern extends StatefulWidget {
  RainbowPattern({Key? key}) : super(key: key);

  @override
  _RainbowPatternState createState() => _RainbowPatternState();
}

class _RainbowPatternState extends State<RainbowPattern> {
  int tick_rate = 100;
  late LedClient client;

  void changeTickRate(int newTickRate) {
    setState(() {
      tick_rate = newTickRate;
    });
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(title: Text("Solid"),),
        body: BlocBuilder<PiipBloc, PiipState>(builder: (context, state) {
          return Column(children: [
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
                    title: ElevatedButton(onPressed: () => {
                      if (state is PiipInitial) {
                        client = LedClient(state.uri.toString()),
                        client.sendMessage(RainbowCycle(tickRate: tick_rate))
                      }
                    }, child: Text("Submit"))
                )
          ]);
        }));
  }
}