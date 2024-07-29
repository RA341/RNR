import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/presentation/setup/setup.dart';
import 'package:rnr/providers/bottomnav.dart';
import 'package:rnr/providers/settings.dart';
import 'package:rnr/services/github.dart';
import 'package:rnr/services/permission_manager.dart';
import 'package:rnr/utils/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  await requestInstallPermissions();
  runApp(
    const ProviderScope(
      child: RNR(),
    ),
  );
}

class RNR extends StatelessWidget {
  const RNR({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RNR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SafeArea(child: Root()),
    );
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstInstall = ref.watch(settingsExistsProvider);

    if (firstInstall.isLoading || firstInstall.isRefreshing) {
      return const Scaffold(body: CircularProgressIndicator());
    }

    if (firstInstall.hasError) {
      return Scaffold(
        body: Text(
          'Whoops something went wrong\n\n${firstInstall.error}',
        ),
      );
    }

    if (firstInstall.hasValue) {
      return const Root();
    }

    return const Text(
      'You have discovered a unhandled case, Congratulations!!, please report this on github.dart',
    );
  }
}

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(bottomNavProvider);

    return Scaffold(
      body: pages[index],
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          // GithubManger.i.getReleases();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => ref.read(bottomNavProvider.notifier).state = value,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
