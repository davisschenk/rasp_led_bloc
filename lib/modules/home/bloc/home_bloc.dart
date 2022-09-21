import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:led_api/led_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LedClient client;

  HomeBloc(this.client) : super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeLoaded) {

    }
  }

  // Stream<HomeState> _mapHomeLoadedToState(HomeEvent event) {
  //   yield* HomeBackend();
  // }
}
