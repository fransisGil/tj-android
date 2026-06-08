import 'fighter.dart';

class Arena {
  final Data match, fight, judge;
  final List<Data> rounds;
  Data? redFighter;
  Data? blackFighter;

  Arena({required this.match, required this.fight, required this.judge, required this.rounds, required String sudutMerah, required String sudutHitam}) {
    redFighter = Data(id: sudutMerah, value: Fighter());
    blackFighter = Data(id: sudutHitam, value: Fighter());
  }

  void reset() {
    redFighter!.value.resetPoints();
    blackFighter!.value.resetPoints();
  }
}

class Data {
  String id;
  dynamic value;
  Data({required this.id, required this.value});
}