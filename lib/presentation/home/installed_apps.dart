import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/providers/installed_apps_provider.dart';

class InstalledApps extends ConsumerWidget {
  const InstalledApps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installedApps = ref.watch(searchAppsAsyncProvider);

    return Flexible(
      flex: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: SearchBar(
              enabled: installedApps.hasValue,
              hintText: 'Search apps',
              onChanged: (value) {
                ref.read(queryProvider.notifier).state = value;
              },
              // trailing: [
              //   IconButton(
              //     onPressed: () {
              //       ref.read(queryProvider.notifier).state = '';
              //     },
              //     icon: const Icon(Icons.cancel_outlined),
              //   ),
              // ],
              leading: const Icon(Icons.search_outlined),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: installedApps.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final e = data[index];
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            if (e.icon != null)
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.memory(e.icon!),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: SizedBox(
                                width: 250,
                                child: Column(
                                  children: [
                                    Text(
                                      '${e.name} v${e.versionName}',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      e.packageName,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Center(child: ErrorWidget(error));
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
