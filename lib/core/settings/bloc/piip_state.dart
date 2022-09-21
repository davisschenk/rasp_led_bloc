part of 'piip_bloc.dart';

abstract class PiipState {
  const PiipState();
  
  List<Object> get props => [];
}

class PiipInitial extends PiipState {
  final Uri uri;
  PiipInitial(this.uri): super();
}

class PiipHasError extends PiipState {
  final String error;
  PiipHasError(this.error): super();
}

