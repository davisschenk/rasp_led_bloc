import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasp_led_bloc/config/themes/themes.dart';
import 'package:rasp_led_bloc/core/settings/bloc/piip_bloc.dart';
import 'package:rasp_led_bloc/core/settings/cubit/piip_cubit.dart';
import 'package:rasp_led_bloc/core/settings/cubit/theme_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [
            BlocBuilder<ThemeCubit, AppTheme>(
              builder: (context, state) {
                return SwitchListTile(
                    title: Text("App Theme"),
                    value: state == AppTheme.Dark,
                    onChanged: (switchState) {
                      if (switchState) {
                        context.read<ThemeCubit>().setDark();
                      } else {
                        context.read<ThemeCubit>().setLight();
                      }
                    });
              },
            ),
            BlocBuilder<PiipBloc, PiipState>(builder: (context, state) {
              return ListTile(
                trailing: IconButton(
                  onPressed: () {
                    context.read<PiipBloc>().save();
                  },
                  icon: Icon(Icons.save),
                ),
                title: TextField(
                  controller: context.read<PiipBloc>().controller,
                  decoration: InputDecoration(
                    errorText: state is PiipHasError ? state.error : null
                  ),
                )
              );
            })
          ],
        ),
      ),
    );
  }
}
