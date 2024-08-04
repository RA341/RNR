import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/database/models/display_release.dart';
import 'package:rnr/providers/release_provider.dart';
import 'package:rnr/repos/repo_list.dart';
import 'package:rnr/utils/services.dart';

final repoIndexProvider = StateProvider<int>((ref) => 0);

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

class BrowseRepoHeader extends ConsumerWidget {
  const BrowseRepoHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repoIndex = ref.watch(repoIndexProvider);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.black45,
          height: 110,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(repoList[repoIndex].repoName),
              const RepoPopUp(),
            ],
          ),
        ),
      ),
    );
  }
}

class RepoPopUp extends ConsumerWidget {
  const RepoPopUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<int>(
      onSelected: (value) {
        ref.read(repoIndexProvider.notifier).state = value;
      },
      itemBuilder: (BuildContext context) => repoWidgets,
    );
  }
}

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
          ? const FetchMoreFooter()
          : AppView(release: repo[index]),
    );

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



    return ElevatedButton(
      onPressed: () {
        ref.read(repoProvider(repoList[repoIndex]).notifier).fetchMore();
      },
      child: const Text('Fetch more tags'),
    );
  }
}

class AppView extends ConsumerWidget {
  const AppView({
    required this.release,
    super.key,
  });

  final DisplayRelease release;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(release.release.name ?? 'No release name');
  }
}
