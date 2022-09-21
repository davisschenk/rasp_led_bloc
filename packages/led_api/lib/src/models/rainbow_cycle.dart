import '../led_api_client.dart';

class RainbowCycle extends Pattern {
  String get name => "rainbow_cycle";

  final int tickRate;

  RainbowCycle({this.tickRate = 100});

  Map<String, dynamic> getArgs() => {"tick_rate": tickRate};
}
