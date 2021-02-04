import 'package:lcu/lcu.dart';

class Summoner {
  int accountId;
  String displayName;
  String internalName;
  bool nameChangeFlag;
  String puuid;
  int profileIconId;
  int summonerId;
  int summonerLevel;
  Summoner.fromJson(Map<String, dynamic> json) {
    accountId = json["accountId"];
    displayName = json["displayName"];
    internalName = json["internalName"];
    nameChangeFlag = json["nameChangeFlag"];
    puuid = json["puuid"];
    profileIconId = json["profileIconId"];
    summonerId = json["summonerId"];
    summonerLevel = json["summonerLevel"];
  }
  // Map<String, dynamic> toJson() {
  //   return {
  //     accountId = json["accountId"];
  //     displayName = json["displayName"];
  //     internalName = json["internalName"];
  //     nameChangeFlag = json["nameChangeFlag"];
  //     puuid = json["puuid"];
  //     profileIconId = json["profileIconId"];
  //     summonerId = json["summonerId"];
  //     summonerLevel = json["summonerLevel"];
  //   }
  // }
}

class RerollInformation {
  int currentPoints;
  int maxRolls;
  int numberOfRolls;
  int pointsCostToRoll;
  int pointsToReroll;
}

class SummonerManager {
  Summoner _currentSummoner;
  LcuApi client;
  final String baseUrl = "/lol-summoner/v1";
  SummonerManager(this.client);
  Future<Summoner> get currentSummoner {
    var res = client.request(HttpMethod.GET, "$baseUrl/current-summoner");
    return res.then<Summoner>((s) {
      return Summoner.fromJson(s);
    });
  }
}
