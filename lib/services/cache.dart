class ClassCache {
  final Map<String, List<Map<String, dynamic>>> _cache = {};

  List<Map<String, dynamic>>? getClasses(String key) {
    return _cache[key];
  }

  void setClasses(String key, List<Map<String, dynamic>> classes) {
    _cache[key] = classes;
  }
}
