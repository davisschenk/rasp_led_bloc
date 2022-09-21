import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'piip_event.dart';
part 'piip_state.dart';

class PiipBloc extends HydratedBloc<PiipEvent, PiipState> {
  late TextEditingController controller;
  
  PiipBloc() : super(PiipInitial(Uri.parse("http://192.168.8.176:8000"))) {
    controller = TextEditingController();
  }

  void save() {
    this.add(PiipNew(controller.text));
  }

  @override
  Stream<PiipState> mapEventToState(
    PiipEvent event,
  ) async* {
    if (event is PiipNew) {
      try {
        yield PiipInitial(Uri.parse(event.newPiip));
      } on FormatException {
        yield PiipHasError("Failed to build URI");
      }
    }
  }

  @override
  PiipState? fromJson(Map<String, dynamic> json) {
    return PiipInitial(Uri.parse(json["piip"] ?? "http://192.168.8.176:8000"));
  }

  @override
  Map<String, dynamic>? toJson(PiipState state) {
    if (state is PiipInitial) {
      return {"piip": state.uri.toString()};
    }

    return {};
  }
}
