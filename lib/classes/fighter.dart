enum Side { red, black }

class Fighter {
  final Side side;
  HitCriteriaCounts punch = HitCriteriaCounts();
  HitCriteriaCounts kick = HitCriteriaCounts();
  PenaltyCounts penalties = PenaltyCounts();

  Fighter(this.side, {required this.punch, required this.kick, required this.penalties});

  int sumPoints() {
    int result = punch.sum() + kick.sum() - penalties.sum();
    return result;
  }

  void resetPoints() {
    punch.reset(); kick.reset(); penalties.reset();
  }
}

class HitCriteriaCounts {
  int muka = 0;
  int badan = 0;
  int goyah = 0;
  final int _mukaFactor;
  final int _badanFactor;
  final int _goyahFactor;

  HitCriteriaCounts({this._badanFactor = 1, this._goyahFactor = 1, this._mukaFactor = 1});

  int sum() => muka * _mukaFactor + badan * _badanFactor + _goyahFactor * goyah;
  

  void addMuka() => muka += 1;

  void addBadan() => badan += 1;

  void addGoyah() => goyah += 1;

  void reset() => muka = badan = goyah = 0;
}

class PenaltyCounts {
  int ringan = 0;
  final int _ringanFactor;
  int berat = 0;
  final int _beratFactor;

  PenaltyCounts({this._beratFactor = 1, this._ringanFactor = 1});

  int sum() {
    return ringan * _ringanFactor + berat * _beratFactor;
  }

  void addRingan() => ringan += 1;

  void addBerat() => berat += 1;

  void reset() => ringan = berat = 0;
}
