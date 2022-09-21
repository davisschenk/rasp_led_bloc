import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rasp_led_bloc/config/themes/themes.dart';

class PiIpCubit extends HydratedCubit<Uri> {
  late TextEditingController field;
  
  PiIpCubit() : super(Uri.parse("http://127.0.0.1:9999")) {
    field = TextEditingController(text: this.state.toString());
  }

  void save() {
    try {
      emit(Uri.parse(field.text));
    } on FormatException {
      print("Format exception");
    }
  }
  
  @override
  Uri fromJson(Map<String, dynamic> json) =>
      Uri.parse(json["piip"]);

  @override
  Map<String, String> toJson(Uri state) => {'piip': state.toString()};
}
