import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oohwee/features/characters/controllers/character_controllers.dart';
import 'package:oohwee/features/characters/views/character_details_view.dart';
import 'package:oohwee/features/characters/views/widgets/character_card.dart';
import 'package:oohwee/util/constants.dart';
import 'package:oohwee/util/extensions/spacing_extensions.dart';
import 'package:oohwee/util/extensions/theme_extensions.dart';
import 'package:oohwee/util/navigate.dart';
import 'package:oohwee/util/util.dart';
import 'package:oohwee/util/widgets/error_widget.dart';
import 'package:oohwee/util/widgets/theme_toggler.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersAsyncValue = ref.watch(charactersProvider(1));
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            title: Text(
              "${AppConstants.appName} 🤘👽🥒",
              style: context.h6?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: ThemeToggler(),
              ),
            ],
          ),
          charactersAsyncValue.when(
            loading: () => const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            error: (e, __) => SliverFillRemaining(
              hasScrollBody: false,
              child: ErrorView(
                refreshCallBack: () => ref.refresh(charactersProvider(1)),
                isConnection: Util.isConnectionError(e),
              ),
            ),
            data: (characters) {
              return SliverToBoxAdapter(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => 24.spacing,
                  padding: 16.0.padA,
                  // physics: const ClampingScrollPhysics(),
                  itemCount: characters.length,
                  itemBuilder: (BuildContext context, int index) {
                    final character = characters[index];
                    return CharacterCard.home(
                      character: character,
                      onTap: () => Navigate.pushPage(
                        context,
                        CharacterDetailsView(character: character),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
