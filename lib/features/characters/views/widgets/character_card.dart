import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oohwee/features/characters/model/character_model.dart';
import 'package:oohwee/features/characters/views/widgets/character_status_widget.dart';
import 'package:oohwee/util/extensions/spacing_extensions.dart';
import 'package:oohwee/util/theme/theme_config.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final bool elevated;
  final Widget child;

  const CharacterCard._internal({
    required this.character,
    required this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    this.elevated = true,
    required this.child,
  });

  factory CharacterCard({
    required Character character,
    required VoidCallback onTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    bool elevated = true,
  }) {
    return CharacterCard._internal(
      character: character,
      onTap: onTap,
      borderRadius: borderRadius,
      elevated: elevated,
      child: _buildHorizontalContent(character),
    );
  }

  factory CharacterCard.home({
    required Character character,
    required VoidCallback onTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    bool elevated = true,
  }) {
    return CharacterCard._internal(
      character: character,
      onTap: onTap,
      borderRadius: borderRadius,
      elevated: elevated,
      child: _buildHomeCharacterCard(character),
    );
  }

  factory CharacterCard.episode({
    required Character character,
    required VoidCallback onTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    bool elevated = false,
  }) {
    return CharacterCard._internal(
      character: character,
      onTap: onTap,
      borderRadius: borderRadius,
      elevated: elevated,
      child: _buildEpisodeCharacterCard(character),
    );
  }

  factory CharacterCard.compact({
    required Character character,
    required VoidCallback onTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    bool elevated = true,
  }) {
    return CharacterCard._internal(
      character: character,
      onTap: onTap,
      borderRadius: borderRadius,
      elevated: elevated,
      child: _buildCompactContent(character),
    );
  }

  factory CharacterCard.vertical({
    required Character character,
    required VoidCallback onTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    bool elevated = true,
  }) {
    return CharacterCard._internal(
      character: character,
      onTap: onTap,
      borderRadius: borderRadius,
      elevated: elevated,
      child: _buildVerticalContent(character),
    );
  }

  factory CharacterCard.detailed({
    required Character character,
    required VoidCallback onTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    bool elevated = true,
  }) {
    return CharacterCard._internal(
      character: character,
      onTap: onTap,
      borderRadius: borderRadius,
      elevated: elevated,
      child: _buildDetailedContent(character),
    );
  }

  factory CharacterCard.withIcon({
    required Character character,
    required VoidCallback onTap,
    required VoidCallback onIconTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    bool elevated = true,
  }) {
    return CharacterCard._internal(
      character: character,
      onTap: onTap,
      borderRadius: borderRadius,
      elevated: elevated,
      child: _buildContentWithIcon(character, onIconTap),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Theme.of(context).cardColor,
        boxShadow: elevated ? [ThemeConfig.cardShadow] : null,
      ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }

  static Widget _buildHorizontalContent(Character character) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterImage(character: character),
        10.spacing,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                CharacterStatusWidget(character: character),
                5.spacing,
                _buildInfo('Last known location:', character.origin.name),
                5.spacing,
                _buildInfo('Origin:', character.location.name),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildHomeCharacterCard(Character character) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterImage(character: character),
        10.spacing,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                CharacterStatusWidget(character: character),
                5.spacing,
                _buildInfo('Last known location:', character.origin.name),
                5.spacing,
                _buildInfo('Origin:', character.location.name),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildEpisodeCharacterCard(Character character) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            character.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  static Widget _buildCompactContent(Character character) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterImage(character: character),
        10.spacing,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Text(
              character.name,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildVerticalContent(Character character) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterImage(character: character),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              CharacterStatusWidget(character: character),
              5.spacing,
              _buildInfo('Last known location:', character.origin.name),
              5.spacing,
              _buildInfo('Origin:', character.location.name),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildDetailedContent(Character character) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterImage(character: character),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name,
                maxLines: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              CharacterStatusWidget(character: character),
              5.spacing,
              _buildInfo('Last known location:', character.origin.name),
              5.spacing,
              _buildInfo('Origin:', character.location.name),
              10.spacing,
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Action 1'),
                  ),
                  10.spacing,
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Action 2'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildContentWithIcon(
    Character character,
    VoidCallback onIconTap,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CharacterImage(character: character),
        10.spacing,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        character.name,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: onIconTap,
                    ),
                  ],
                ),
                CharacterStatusWidget(character: character),
                5.spacing,
                _buildInfo('Last known location:', character.origin.name),
                5.spacing,
                _buildInfo('Origin:', character.location.name),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildInfo(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
            color: Colors.grey,
          ),
        ),
        Text(
          content,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }
}

class CharacterImage extends StatelessWidget {
  final Character character;

  const CharacterImage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: character.id,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
        child: CachedNetworkImage(
          imageUrl: character.image,
          height: 155.0,
          // placeholder: (context, url) => const Center(
          //   child: CircularProgressIndicator(),
          // ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover, // Adjust fit if necessary
        ),
      ),
    );
  }
}
