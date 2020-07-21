library link_preview;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LinkPreview {

  static final LinkPreview _singleton = LinkPreview._internal();

  factory LinkPreview() => _singleton;

  LinkPreview._internal();

  static Map<String, String> _schemeMap = Map();

  static Future<Map> _cacheOEmbedSchemeMap() async {
    if (_schemeMap.length > 0) {
      return _schemeMap;
    }
    try {
      _schemeMap.clear();
      Response response = await http.get("https://oembed.com/providers.json");
      if (_schemeMap.length > 0) {
        return _schemeMap;
      }

      List<dynamic> items = jsonDecode(response.body);

      for (dynamic item in items) {
        try {
          var endpoints = item["endpoints"];
          String providerUrl = item["provider_url"];
          for (dynamic endpoint in endpoints) {
            var schemes = endpoint["schemes"];
            String url = endpoint["url"];
            url = url.replaceAll("{format}", "json");
            if (schemes == null) {
              if (!url.endsWith(".xml")) {
                _schemeMap[providerUrl + ".+"] = url;
              }
              continue;
            }
            for (String scheme in schemes) {
              scheme = scheme.replaceAll("*", ".+");
              scheme = scheme.replaceAll("http://", "https://");
              _schemeMap[scheme] = url;
            }
          }
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
    return _schemeMap;
  }

  /// Apps can warm up link_preview on app launch using this API.
  /// Warm up API will cache data needed to extract page info.
  /// Warm up is an optional step. Warming up will help reduce 1-2 seconds on first page load.
  static Future<void> warmUp() async {
    await _cacheOEmbedSchemeMap();
  }

  /// This API return page information if the provided url.
  /// Page information will be in OEmbed response structure.
  /// Ref. https://oembed.com/#section2
  ///
  /// Returns null if there is error in loading page information
  static Future<dynamic> getPageInfo(String url) async {
    try {
      Map<String, String> schemeMap = await _cacheOEmbedSchemeMap();

      String oembedUrl;
      schemeMap.forEach((key, value) {
        RegExp exp = new RegExp(key);

        Iterable<Match> matches = exp.allMatches(url);
        if (matches.length > 0) {
          oembedUrl = "$value?format=json&url=$url";
        }
      });

      if (oembedUrl == null) {
        print("Match not found for $url");
        return null;
      }

      Response response = await http.get(oembedUrl);
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
