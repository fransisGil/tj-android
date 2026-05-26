import 'fighter.dart';

class Arena {
  final String location, arena, judge;
  final List<String> matches;
  final Fighter redFighter = Fighter(Side.red);
  final Fighter blackFighter = Fighter(Side.black);

  Arena({required this.arena, required this.location, required this.judge, required this.matches});

  void reset() {
    redFighter.resetPoints();
    blackFighter.resetPoints();
  }
}