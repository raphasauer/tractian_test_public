abstract class Base {
  final String name;
  List<Base> children;
  final String id;
  final String? parentId;

  Base({
    required this.name,
    required this.children,
    required this.id,
    required this.parentId,
  });
}
