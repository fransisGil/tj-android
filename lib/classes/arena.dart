import 'fighter.dart';

class Arena {
  final Data match, fight, judge;
  final List<int> rounds;
  Fighter? redFighter;
  Fighter? blackFighter;

  Arena({required this.match, required this.fight, required this.judge, required this.rounds}) {
    redFighter = Fighter();
    blackFighter = Fighter();
  }

  void reset() {
    redFighter!.resetPoints();
    blackFighter!.resetPoints();
  }
}

class Data {
  String id, value;
  Data({required this.id, required this.value});
}