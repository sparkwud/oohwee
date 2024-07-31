import 'package:flutter/material.dart';
import 'package:oohwee/features/characters/model/character_model.dart';
import 'package:oohwee/util/extensions/spacing_extensions.dart';

class CharacterStatusWidget extends StatelessWidget {
  const CharacterStatusWidget({
    super.key,
    required this.character,
    this.showSpecies = true,
  });
  final Character character;
  final bool showSpecies;

  @override
  Widget build(BuildContext context) {
    CharacterStatus characterStatus = character.status;
    return Row(
      children: [
        Container(
          height: 7.0,
          width: 7.0,
          decoration: BoxDecoration(
            color: characterStatus.color,
            shape: BoxShape.circle,
          ),
        ),
        5.spacing,
        Text(
          characterStatus.status,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.0,
          ),
        ),
        if (showSpecies)
          Text(
            ' - ${character.species}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
      ],
    );
  }
}

enum CharacterStatus {
  alive(
    status: "Alive",
    color: Color.fromRGBO(129, 199, 132, 1),
  ),

  dead(
    status: "Dead",
    color: Colors.red,
  ),

  unknown(
    status: "Unknown",
    color: Colors.blueGrey,
  );

  const CharacterStatus({
    required this.status,
    required this.color,
  });
  final String status;
  final Color color;
}

extension CharacterStatusExtension on CharacterStatus {
  static CharacterStatus fromString(String status) {
    // final statusLower = status.toLowerCase();
    switch (status.toLowerCase()) {
      case 'alive':
        return CharacterStatus.alive;
      case 'dead':
        return CharacterStatus.dead;
      case 'unknown':
        return CharacterStatus.unknown;
      default:
        throw ArgumentError('Invalid character status: $status');
    }
  }
}
