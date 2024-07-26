import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rnr/presentation/browse/browse.dart';
import 'package:rnr/presentation/home/home.dart';
import 'package:rnr/presentation/settings/settings.dart';
import 'package:rnr/providers/bottomnav.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SafeArea(child: Root()),
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
