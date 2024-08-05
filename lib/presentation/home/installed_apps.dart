import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/providers/installed_apps_provider.dart';

class InstalledApps extends ConsumerWidget {
  const InstalledApps({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final installedApps = ref.watch(installedAppsProvider);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: installedApps.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final e = data[index];

                return Row(
                  children: [
                    if (e.icon != null)
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.memory(e.icon!),
                      ),
                    Text('${e.packageName} ${e.versionName}'),
                  ],
                );
              },
            );
          },
          error: (error, stackTrace) {
            return ErrorWidget(error);
          },
          loading: () {
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
