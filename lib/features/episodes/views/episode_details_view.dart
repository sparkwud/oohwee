import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/features/characters/views/widgets/character_card.dart';
import 'package:oohwee/features/characters/views/widgets/info_card.dart';
import 'package:oohwee/features/episodes/controllers/episode_controllers.dart';
import 'package:oohwee/features/episodes/model/episode_model.dart';
import 'package:oohwee/util/widgets/error_widget.dart';

class EpisodeDetailsView extends ConsumerWidget {
  final Episode episode;

  const EpisodeDetailsView({super.key, required this.episode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          episode.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          InfoCard.episode(episode: episode),
          const SizedBox(height: 24),
          const Text(
            'Characters',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _buildCharactersList(ref),
        ],
      ),
    );
  }

  Widget _buildCharactersList(WidgetRef ref) {
    return ref.watch(episodeCharactersProvider(episode.id)).when(
          data: (characters) => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return CharacterCard.episode(
                character: character,
                onTap: () {},
              );
            },
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            return ErrorView(
              refreshCallBack: () =>
                  ref.refresh(episodeCharactersProvider(episode.id)),
              isConnection: false,
            );
          },
        );
  }
}
