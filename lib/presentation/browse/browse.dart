import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/models/display_release.dart';
import 'package:rnr/presentation/browse/browse_header.dart';
import 'package:rnr/providers/browse_provider.dart';
import 'package:rnr/repos/repo_list.dart';
import 'package:rnr/utils/services.dart';
import 'package:rnr/utils/utils.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

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

    return ref.read(repoProvider(repoList[repoIndex]).notifier).isLoading
        ? const Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          )
        : ElevatedButton(
            onPressed:
                ref.read(repoProvider(repoList[repoIndex]).notifier).fetchMore,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(rel.release.name ?? 'No release name'),
            if (releaseDate != null)
              Text('Released ${timeago.format(
                releaseDate,
                locale: 'en_short',
              )} ago'),
          ],
        ),
        ActionButtons(rel: rel),
      ],
    );
  }

  void downloadAndInstall(String url) {
    print('downloading $url');
  }
}

class ActionButtons extends ConsumerStatefulWidget {
  const ActionButtons({required this.rel, super.key});

  final DisplayRelease rel;

  @override
  ConsumerState createState() => _ActionButtonsState();
}

class _ActionButtonsState extends ConsumerState<ActionButtons>
    with SingleTickerProviderStateMixin {
  late final rel = widget.rel;

  @override
  void initState() {
    assetAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    super.initState();
  }

  @override
  void dispose() {
    assetAnimController.dispose();
    super.dispose();
  }

  late final AnimationController assetAnimController;

  bool showAssets = false;

  @override
  Widget build(BuildContext context) {
    final releaseUrl = rel.release.htmlUrl;
    final readme = rel.release.body;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () async {
                setState(() {
                  showAssets = !showAssets;
                  if (showAssets) {
                    assetAnimController.forward(from: 100);
                  } else {
                    assetAnimController.reverse(from: 100);
                  }
                });
              },
              icon: const Icon(Icons.list_outlined),
              tooltip: 'assets',
            ),
            if (releaseUrl != null)
              IconButton(
                onPressed: () async {
                  final url = Uri.parse(releaseUrl);
                  if (!await launchUrl(url)) {
                    logger.e('Could not launch $url');
                  }
                },
                icon: const Icon(Icons.link_sharp),
                tooltip: 'Release url',
              ),
            IconButton(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierColor: Colors.black,
                  builder: (context) {
                    return Markdown(
                      data: readme ?? 'No release notes found',
                      selectable: true,
                    );
                  },
                );
              },
              icon: const Icon(Icons.read_more),
              tooltip: 'Readme',
            ),
          ],
        ),
        if (showAssets)
          AssetBuilder(rel: rel)
              .animate(controller: assetAnimController)
              .moveY(),
      ],
    );
  }
}

class AssetBuilder extends ConsumerWidget {
  const AssetBuilder({required this.rel, super.key});

  final DisplayRelease rel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assets = rel.assets!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        children: assets
            .map(
              (asset) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(asset.name),
                      Text(asset.version),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Arch: ${asset.arch}'),
                      Text(
                        '${convertBytes(asset.size).toStringAsPrecision(4)} MB',
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.download),
                      ),
                    ],
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
