enum Side { red, black }

class Fighter {
  final Side side;
  int points = 0;

  Fighter(this.side);

  void addPoints(int points) {
    this.points += points;
  }

  void resetPoints() {
    points = 0;
  }

  void removePoints(int points) {
    this.points -= points;
    if (this.points < 0) {
      this.points = 0;
    }
  }
}

