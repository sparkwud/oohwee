import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/features/characters/model/character_model.dart';
import 'package:oohwee/features/episodes/controllers/episode_controllers.dart';
import 'package:oohwee/features/episodes/views/episode_details_view.dart';
import 'package:oohwee/util/extensions/spacing_extensions.dart';
import 'package:oohwee/util/navigate.dart';
import 'package:oohwee/util/util.dart';
import 'package:oohwee/util/widgets/error_widget.dart';

import 'widgets/character_app_bar.dart';
import 'widgets/info_card.dart';

class CharacterDetailsView extends ConsumerWidget {
  final Character character;

  const CharacterDetailsView({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 230,
            pinned: true,
            flexibleSpace: CharacterAppBar(character: character),
          ),
          SliverPadding(
            padding: 16.0.padA,
            sliver: SliverToBoxAdapter(
              child: InfoCard(character: character),
            ),
          ),
          _buildEpisodes(ref),
        ],
      ),
    );
  }

  Widget _buildEpisodes(WidgetRef ref) {
    final episodesAsyncValue = ref.watch(episodesProvider(1));

    return episodesAsyncValue.when(
      data: (episodes) => SliverPadding(
        padding: 16.0.padH,
        sliver: SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.spacing,
              const Text(
                'Episodes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.spacing,
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: episodes.length,
                separatorBuilder: (context, index) => 4.spacing,
                itemBuilder: (context, index) {
                  final episode = episodes[index];
                  return Card(
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text(
                        episode.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(episode.episode),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigate.pushPage(
                          context,
                          EpisodeDetailsView(episode: episode),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, __) => SliverToBoxAdapter(
        child: ErrorView(
          refreshCallBack: () => ref.refresh(episodeProvider(1)),
          isConnection: Util.isConnectionError(e),
        ),
      ),
    );
  }
}


   // leadingWidth: 50,
            // leading: Padding(
            //   padding: const EdgeInsets.only(left: 16.0),
            //   child: Container(
            //     // alignment: Alignment.center,
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: context.colorScheme.onSecondary,
            //     ),
            //     // padding: 4.0.padA,
            //     child: IconButton(
            //       iconSize: 18,
            //       icon: const Icon(Icons.arrow_back),
            //       onPressed: () => Navigator.pop(context),
            //     ),
            //   ),
            // ),
            // title: const Text(
            //   "  character.name",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w700,
            //     color: Colors.white,
            //   ),
            // ),