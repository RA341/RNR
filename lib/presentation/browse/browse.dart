import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:rnr/database/models/display_release.dart';
import 'package:rnr/presentation/browse/browse_header.dart';
import 'package:rnr/providers/browse_provider.dart';
import 'package:rnr/repos/repo_list.dart';
import 'package:rnr/utils/utils.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return repoList.isEmpty
        ? const Center(child: Text('No Repos configured'))
        : const Column(
            children: [
              BrowseRepoHeader(),
              Expanded(child: ReleaseList()),
            ],
          );
  }
}

// main list

class ReleaseList extends ConsumerWidget {
  const ReleaseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repoIndex = ref.watch(repoIndexProvider);
    final repo = ref.watch(repoProvider(repoList[repoIndex]));

    final fullListLength = repo.length + 1;
    return ListView.builder(
      itemCount: fullListLength,
      itemBuilder: (context, index) => fullListLength - 1 == index
          ? const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 75,
              ),
              child: FetchMoreFooter(),
            )
          : ReleaseView(rel: repo[index]),
    );
    // TODO handling error when stream goes down
    //     git.logRateLimits();
    //     return Text('Something went went wrong: $error');
    //     return const CircularProgressIndicator();
  }
}

class FetchMoreFooter extends ConsumerWidget {
  const FetchMoreFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repoIndex = ref.watch(repoIndexProvider);
    final releasesController =
        ref.read(repoProvider(repoList[repoIndex]).notifier);

    return releasesController.isLoading
        ? const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : ElevatedButton(
            onPressed: releasesController.fetchMore,
            child: const Text(
              'Fetch more releases',
              style: TextStyle(fontSize: 16),
            ),
          );
  }
}

class ReleaseView extends ConsumerWidget {
  const ReleaseView({
    required this.rel,
    super.key,
  });

  final DisplayRelease rel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final releaseDate = rel.release.createdAt;

    return Column(
      children: [
        Text(rel.release.name ?? 'No release name'),
        if (releaseDate != null)
          Text('Released ${timeago.format(
            releaseDate,
            locale: 'en_short',
          )} ago'),
        Row(
          children: [
            const Text('Release Notes'),
            IconButton(
                onPressed: () {
                  // downloadAndInstall()
                },
                icon: const Icon(Icons.download))
          ],
        )
      ],
    );
  }

  void downloadAndInstall(String url) {
    print('downloading $url');
  }
}
