import '../led_api_client.dart';

class Meteor extends Pattern {
  String get name => "meteor";

  final int tickRate;
  final List color;
  final bool randomDecay;
  final int decay;
  final int size;

  Meteor(
      {this.tickRate = 100,
      this.color = const [255, 0, 255, 0],
      this.randomDecay = true,
      this.decay = 128,
      this.size = 16});

  Map<String, dynamic> getArgs() => {
        "tick_rate": tickRate,
        "color": color,
        "random_decay": randomDecay,
        "decay": decay,
        "size": size,
      };
}
