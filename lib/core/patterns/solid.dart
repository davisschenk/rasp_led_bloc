import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:led_api/led_api.dart';
import 'package:rasp_led_bloc/core/settings/bloc/piip_bloc.dart';
import 'package:rasp_led_bloc/widgets/color_selector.dart';

class SolidPattern extends StatefulWidget {
  SolidPattern({Key? key}) : super(key: key);

  @override
  _SolidPatternState createState() => _SolidPatternState();
}

class _SolidPatternState extends State<SolidPattern> {
  Color color = Color(0);
  late LedClient client;

  void changeColor(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Solid"),),
        body: BlocBuilder<PiipBloc, PiipState>(builder: (context, state) {
          return Column(children: [
                ListTile(
                  title: Text("Color"),
                  trailing: ColorSelector(color, (c) => color = c)
                ),
                ListTile(
                    title: ElevatedButton(onPressed: () => {
                      if (state is PiipInitial) {
                        client = LedClient(state.uri.toString()),
                        client.sendMessage(Solid(color: [color.blue, color.green, color.red, 0]))
                      }
                    }, child: Text("Submit"))
                )
          ]);
        }));
  }
}
