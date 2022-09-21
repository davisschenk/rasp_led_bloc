part of 'piip_bloc.dart';

abstract class PiipEvent {
  const PiipEvent();

  @override
  List<Object> get props => [];
}

class PiipNew extends PiipEvent {
  final String newPiip;

  PiipNew(this.newPiip) : super();
}