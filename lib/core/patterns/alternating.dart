import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:led_api/led_api.dart';
import 'package:rasp_led_bloc/core/settings/bloc/piip_bloc.dart';
import 'package:rasp_led_bloc/widgets/color_selector.dart';

class AlternatingPattern extends StatefulWidget {
  AlternatingPattern({Key? key}) : super(key: key);

  @override
  _AlternatingPatternState createState() => _AlternatingPatternState();
}

class _AlternatingPatternState extends State<AlternatingPattern> {
  List<ColorSection> colors = [];
  late LedClient client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Solid"),
        ),
        body: Column(children: [
          ExpansionTile(title: Text("Colors"), children: [
            ElevatedButton(
                child: Text("Add Color Section"),
                onPressed: () {
                  setState(() {
                    colors.add(ColorSection([0, 0, 0, 0], 0));
                  });
                }),
            for (MapEntry i in colors.asMap().entries)
              ListTile(
                  leading: ColorSelector(
                      Color.fromARGB(0, colors[i.key].color[2],
                          colors[i.key].color[0], colors[i.key].color[1]), (c) {
                    setState(() {
                      colors[i.key].color = [c.blue, c.green, c.red, 0];
                    });
                  }),
                  trailing: Container(
                    width: 10,
                    child: TextField(
                        onChanged: (n) =>
                            colors[i.key].count = int.tryParse(n) ?? 1),
                  ))
          ]),
          BlocBuilder<PiipBloc, PiipState>(builder: (context, state) {
            return ListTile(
                title: ElevatedButton(
                    onPressed: () => {
                          if (state is PiipInitial)
                            {
                              client = LedClient(state.uri.toString()),
                              client.sendMessage(Alternating(colors))
                            }
                        },
                    child: Text("Submit")));
          })
        ]));
  }
}
