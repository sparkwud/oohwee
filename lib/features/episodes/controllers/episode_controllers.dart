import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/api/api_service.dart';
import 'package:oohwee/features/characters/model/character_model.dart';
import 'package:oohwee/features/episodes/model/episode_model.dart';

final episodesProvider =
    FutureProvider.family<List<Episode>, int>((ref, page) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getEpisodes(page: page);
});

final episodeProvider = FutureProvider.family<Episode, int>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getEpisodeById(id);
});

final episodeCharactersProvider =
    FutureProvider.family<List<Character>, int>((ref, episodeId) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getEpisodeCharacters(episodeId);
});
