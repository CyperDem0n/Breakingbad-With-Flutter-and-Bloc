class Character {
  late int charId;
  late String name;
  late String nickname;
  late String img;
  late List<dynamic> jobs;
  late String statusIfDeadOrAlive;
  late List<dynamic> appearance;
  late String actorName;
  late String categoryForSeires;
  late List<dynamic> betterCallSaulAppearance;

  Character.fromJson(Map<String, dynamic> jsonData) {
    charId = jsonData['char_id'];
    name = jsonData['name'];
    nickname = jsonData['nickname'];
    img = jsonData['img'];
    jobs = jsonData['occupation'];
    statusIfDeadOrAlive = jsonData['status'];
    appearance = jsonData['appearance'];
    actorName = jsonData['portrayed'];
    categoryForSeires = jsonData['category'];
    betterCallSaulAppearance = jsonData['better_call_saul_appearance'];
  }
  
}

