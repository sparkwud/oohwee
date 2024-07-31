import 'package:flutter/material.dart';
import 'package:oohwee/features/characters/model/character_model.dart';
import 'package:oohwee/features/characters/views/widgets/character_status_widget.dart';
import 'package:oohwee/features/episodes/model/episode_model.dart';

class InfoCard extends StatelessWidget {
  final Character? character;
  final Episode? episode;
  final Widget child;

  const InfoCard._({
    this.character,
    this.episode,
    required this.child,
  });

  factory InfoCard({
    required Character character,
  }) {
    return InfoCard._(
      character: character,
      child: buildCharacterInfoCard(character),
    );
  }

  factory InfoCard.character({
    required Character character,
  }) {
    return InfoCard._(
      character: character,
      child: buildCharacterInfoCard(character),
    );
  }

  factory InfoCard.episode({
    required Episode episode,
  }) {
    return InfoCard._(
      episode: episode,
      child: buildEpisodeInfoCard(episode),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }

  static Widget buildInfoRow(String label, String content, [Widget? other]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          other ?? Text(content),
        ],
      ),
    );
  }

  static Widget buildCharacterInfoCard(character) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow(
          'Status',
          '',
          CharacterStatusWidget(
            character: character,
            showSpecies: false,
          ),
        ),
        // buildInfoRow('Species', character.species),
        buildInfoRow('Gender', character.gender),
        buildInfoRow('Origin', character.origin.name),
        buildInfoRow('Location', character.location.name),
      ],
    );
  }

  static Widget buildEpisodeInfoCard(episode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildInfoRow('Episode', episode.episode),
        buildInfoRow('Air Date', episode.airDate),
      ],
    );
  }
}
