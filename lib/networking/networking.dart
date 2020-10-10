import 'package:friendsepisode/model/episode.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';

class NetworkHelper {
  static final String baseUrl = 'https://api.themoviedb.org/3/tv/1668/season';
  static final String apiKey = '81f340338a84311b318b04a016742e74';

  static Future<Episode> fetchEpisode(
      http.Client client, int seasonNumber, int episodeNumber) async {
    final response = await client.get(
        '$baseUrl/$seasonNumber/episode/$episodeNumber?api_key=$apiKey&language=en-US');
    print(response.statusCode);
    return compute(parseEpisode, response.body);
  }

  static Episode parseEpisode(responseBody) {
    final Map parsed = json.decode(responseBody);
    final episode = Episode.fromJson(parsed);
    return episode;
  }
}
