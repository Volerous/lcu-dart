import 'package:flutter_test/flutter_test.dart';
import 'package:lcu/lcu.dart';

void main() {
  test('adds one to input values', () async {
    final api = LcuApi("C:/Riot Games/League of Legends");
    print(api.port);
    // var res = await api.request(HttpMethod.GET, "/lol-summoner/v1/current-summoner");
    var pages = await api.runeManager.allRunePages;
    // var page = await api.runeManager.currentRunePage;
    int i = 0;
    var retPage = pages[i];
    print("from: " + pages[i + 1].name);
    print("to: " + retPage.name);
    retPage.selectedPerkIds = pages[i + 1].selectedPerkIds;
    retPage.primaryStyleId = pages[i + 1].primaryStyleId;
    retPage.subStyleId = pages[i + 1].subStyleId;
    retPage.name = "updated";
    var res1 = await api.runeManager.setRunePage(retPage);
  });
}
