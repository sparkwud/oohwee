import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/api/api_service.dart';
import 'package:oohwee/features/characters/model/character_model.dart';

final charactersProvider =
    FutureProvider.family<List<Character>, int>((ref, page) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getCharacters(page: page);
});

final characterProvider =
    FutureProvider.family<Character, int>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getCharacterById(id);
});
