import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/providers/github.dart';
import 'package:rnr/repos/repo_list.dart';

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
              ReleaseList(),
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

    return ListView(
      children: const [
        Text('!st release'),
        Text('!as release'),
        Text('!asd release'),
        Text('!asd release'),
      ],
    );
  }
}
