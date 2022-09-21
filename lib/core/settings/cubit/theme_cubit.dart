import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rasp_led_bloc/config/themes/themes.dart';

class ThemeCubit extends HydratedCubit<AppTheme> {
  ThemeCubit() : super(AppTheme.Dark);

  get themeData => appThemeData[state];

  void setDark() => emit(AppTheme.Dark);
  void setLight() => emit(AppTheme.Light);

  @override
  AppTheme fromJson(Map<String, dynamic> json) =>
      AppTheme.values[json["theme"] as int];

  @override
  Map<String, int> toJson(AppTheme state) => {'theme': state.index};
}
