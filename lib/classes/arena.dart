import 'fighter.dart';

class Arena {
  final HitCriteriaCounts _punchFactors = HitCriteriaCounts(
    badanFactor: 1,
    goyahFactor: 3,
    mukaFactor: 2,
  );
  final HitCriteriaCounts _kickFactors = HitCriteriaCounts(
    badanFactor: 2,
    goyahFactor: 4,
    mukaFactor: 3,
  );
  final PenaltyCounts _penaltyFactors = PenaltyCounts(beratFactor: 2);

  final Data match, fight, judge;
  final List<int> rounds;
  late Fighter redFighter;
  late Fighter blackFighter;

  Arena({required this.match, required this.fight, required this.judge, required this.rounds}) {
    redFighter = blackFighter = Fighter(Side.red, punch: _punchFactors, kick: _kickFactors, penalties: _penaltyFactors);
  }

  void reset() {
    redFighter.resetPoints();
    blackFighter.resetPoints();
  }
}

class Data {
  String id, value;
  Data({required this.id, required this.value});
}