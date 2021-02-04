import 'dart:convert';

import 'package:lcu/lcu.dart';


class RunePage{
  String name;
  int id;
  bool isActive;
  bool isDeletable;
  bool isEditable;
  bool isValid;
  DateTime lastModified;
  List<int> selectedPerkIds;
  int order;
  int primaryStyleId;
  int subStyleId;
  RunePage.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
    isActive = json["isActive"];
    isDeletable = json["isDeletable"];
    isEditable = json["isEditable"];
    isValid = json["isValid"];
    lastModified = DateTime.fromMicrosecondsSinceEpoch(json["lastModified"]);
    order = json["order"];
    primaryStyleId = json["primaryStyleId"];
    subStyleId = json["subStyleId"];
    selectedPerkIds = (json["selectedPerkIds"] as List).cast<int>();
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "isActive": isActive,
      "isDeletable": isDeletable,
      "isEditable": isEditable,
      "isValid": selectedPerkIds.any((element) => element == 0),
      "lastModified": lastModified.microsecondsSinceEpoch,
      "order": order,
      "primaryStyleId": primaryStyleId,
      "subStyleId": subStyleId,
      "selectedPerkIds": selectedPerkIds
    };
  }
}

class RuneManager {
  LcuApi client;
  String baseUrl = "/lol-perks/v1";
  RuneManager(this.client);
  Future<List<RunePage>> get allRunePages {
    var res = client
        .request(HttpMethod.GET, "$baseUrl/pages")
        .then<List<RunePage>>((r) {
      var ret = (r as List)
          .map<RunePage>((e) => RunePage.fromJson(e))
          .where((e) => e.isEditable)
          .toList();
      ret.sort((a, b) => a.order.compareTo(b.order));
      return ret;
    });
    return res;
  }

  Future<RunePage> get currentRunePage {
    return client
        .request(HttpMethod.GET, "$baseUrl/currentpage")
        .then<RunePage>((r) {
      return RunePage.fromJson(r);
    });
  }

  Future setRunePage(RunePage page) {
    var body = jsonEncode(page.toJson());
    var res = client.request(HttpMethod.POST, "$baseUrl/pages", body);
    return res;
  }
}
