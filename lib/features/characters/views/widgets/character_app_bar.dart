import 'package:flutter/material.dart';
import 'package:oohwee/features/characters/model/character_model.dart';

class CharacterAppBar extends StatelessWidget {
  const CharacterAppBar({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      // titlePadding: EdgeInsets.zero,

      title: Text(
        character.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      background: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            stops: const [0.6, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.darken,
        child: Hero(
          tag: character.id,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
