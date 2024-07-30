import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/api/api_service.dart';
import 'package:oohwee/features/locations/model/location_model.dart';

final locationsProvider =
    FutureProvider.family<List<Location>, int>((ref, page) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getLocations(page: page);
});

final locationProvider = FutureProvider.family<Location, int>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getLocationById(id);
});
