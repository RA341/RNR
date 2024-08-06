/// Model to describe apps shown in browse view
class InstalledApp {
  InstalledApp({
    required this.name,
    required this.arch,
    required this.version,
    required this.downloadUrl,
    required this.repo,
  });

  String name;
  String version;

  /// App architecture
  String arch;

  String repo;

  String downloadUrl;
}
