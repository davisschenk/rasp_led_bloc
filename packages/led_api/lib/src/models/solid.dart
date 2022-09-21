import '../led_api_client.dart';

class Solid extends Pattern {
  String get name => "solid";

  final List color;

  Solid({this.color = const [255, 0, 255, 0]});

  Map<String, dynamic> getArgs() => {
        "color": color,
      };
}
