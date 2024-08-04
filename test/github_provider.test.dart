// import 'package:riverpod/riverpod.dart';
// import 'package:rnr/providers/browse_provider.dart';
// import 'package:rnr/repos/sources/revancedapks.buildapps.dart';
// import 'package:test/test.dart';
//
// /// A testing utility which creates a [ProviderContainer] and automatically
// /// disposes it at the end of the test.
// ProviderContainer createContainer({
//   ProviderContainer? parent,
//   List<Override> overrides = const [],
//   List<ProviderObserver>? observers,
// }) {
//   // Create a ProviderContainer, and optionally allow specifying parameters.
//   final container = ProviderContainer(
//     parent: parent,
//     overrides: overrides,
//     observers: observers,
//   );
//
//   // When the test ends, dispose the container.
//   addTearDown(container.dispose);
//
//   return container;
// }
//
// void main() {
//   test('Some description', () async {
//     final container = createContainer();
//     final repo = BuildApps();
//
//     container.read(repoProvider(repo))
//       .when(
//         data: (data) {
//           for (var element in data) {
//             print(element.release.name);
//             print(element.assets?.length);
//             element.assets?.forEach(
//               (element) {
//                 print(element.name);
//               },
//             );
//           }
//         },
//         error: (error, stackTrace) {
//           print(error);
//         },
//         loading: () {
//           print('Loading');
//         },
//       );
//
//     container.read(repoProvider(repo).notifier).fetchMore();
//
//     final f = await container.read(repoProvider(repo).future);
//
//     expect(
//       f.length,
//       equals(10),
//     );
//   });
// }
