import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/features/characters/model/character_model.dart';
import 'package:oohwee/features/episodes/model/episode_model.dart';
import 'package:oohwee/features/locations/model/location_model.dart';
import 'package:oohwee/util/constants.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
    ),
  );

  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/character',
        queryParameters: {
          'page': page,
        },
      );
      return (response.data['results'] as List)
          .map((json) => Character.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load characters: $e');
    }
  }

  Future<Character> getCharacterById(int id) async {
    try {
      final response = await _dio.get('/character/$id');
      return Character.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load character: $e');
    }
  }

  Future<List<Location>> getLocations({int page = 1}) async {
    try {
      final response =
          await _dio.get('/location', queryParameters: {'page': page});
      return (response.data['results'] as List)
          .map((json) => Location.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load locations: $e');
    }
  }

  Future<Location> getLocationById(int id) async {
    try {
      final response = await _dio.get('/location/$id');
      return Location.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load location: $e');
    }
  }

  Future<List<Episode>> getEpisodes({int page = 1}) async {
    try {
      final response =
          await _dio.get('/episode', queryParameters: {'page': page});
      return (response.data['results'] as List)
          .map((json) => Episode.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load episodes: $e');
    }
  }

  Future<Episode> getEpisodeById(int id) async {
    try {
      final response = await _dio.get('/episode/$id');
      return Episode.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load episode: $e');
    }
  }

  Future<List<Episode>> getEpisodesByIds(List<String> ids) async {
    try {
      final response = await _dio.get('/episode/$ids');
      if (response is Map<String, dynamic>) {
        return [Episode.fromJson(response.data)];
      }
      return (response.data as List).map((e) => Episode.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load episode: $e');
    }
  }

  Future<List<Character>> getEpisodeCharacters(int episodeId) async {
    try {
      final episodeResponse = await _dio.get('/episode/$episodeId');
      final characterUrls =
          List<String>.from(episodeResponse.data['characters']);

      if (characterUrls.isEmpty) {
        return [];
      }

      final characterIds =
          characterUrls.map((url) => int.parse(url.split('/').last)).toList();

      final charactersResponse = await _dio.get('/character/$characterIds');

      if (charactersResponse.data is Map<String, dynamic>) {
        return [Character.fromJson(charactersResponse.data)];
      }

      return (charactersResponse.data as List)
          .map((json) => Character.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load episode characters: $e');
    }
  }

  Future<List<Episode>> getCharacterEpisodes(int characterId) async {
    try {
      final character = await getCharacterById(characterId);
      final episodeUrls = character.episode;

      if (episodeUrls.isEmpty) {
        return [];
      }
      final episodeIds = episodeUrls.map((url) => url.split('/').last).toList();
      final episodes = await getEpisodesByIds(episodeIds);
      return episodes;
    } catch (e) {
      throw Exception('Failed to load character episodes: $e');
    }
  }
}
