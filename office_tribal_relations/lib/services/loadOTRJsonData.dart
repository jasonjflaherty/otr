import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:office_tribal_relations/model/otrpages_factory.dart';

class LoadData {
  //List<OtrPages> _categories;

  Future<String> _loadOTRPageAsset() async {
    return await rootBundle.loadString('assets/data/otrpages.json');
  }

  Future loadOtrPage() async {
    String jsonOTRPage = await _loadOTRPageAsset();
    return parseJson(jsonOTRPage);
  }

  List<OtrPages> parseJson(String response) {
    if (response == null) {
      return [];
    }
    final parsed =
        json.decode(response.toString()).cast<Map<String, dynamic>>();
    List otrdata =
        parsed.map<OtrPages>((json) => new OtrPages.fromJson(json)).toList();

    return otrdata;
  }
}
