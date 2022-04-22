class Avenger {
  final String name;
  Avenger(this.name);
  Avenger.blackWidow({required this.name});
  Avenger.ironMan({required this.name});
  Avenger.antman({required this.name});
  Avenger.chantMan({required this.name});

  void saveAmerica() {
    print("Saving america loading...");
  }
}

void startingPoint() {
  final hehe = Avenger("hehe");
  final blackWidow = Avenger.blackWidow(name: "Natasha");
  final ironMan = Avenger.ironMan(name: "Tony Stark");
  ironMan.saveAmerica();
  ironMan.name;
  blackWidow.saveAmerica();
  hehe.saveAmerica();
}
