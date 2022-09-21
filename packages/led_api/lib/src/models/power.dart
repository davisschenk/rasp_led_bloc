import '../led_api_client.dart';

class Power extends Message {
  String get name => "solid";

  final String mode;

  Power(this.mode);


  @override
  Map<String, dynamic> getData() {
    return {"mode": mode};
  }

  @override
  String get type => "power";
}
