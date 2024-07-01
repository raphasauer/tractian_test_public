import 'package:tractian_test/models/base.dart';

/// Base class for repository in this project. Should be extended.
abstract class BaseRepository {
  Future<List<Base>> loadAssets(String unit);
  List<Base> parseLocations(List<dynamic> json);
  List<Base> parseAssets(List<dynamic> json);
}
