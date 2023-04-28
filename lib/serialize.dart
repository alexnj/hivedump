String serialize(dynamic object) {
  if (object is String) {
    return '"${object.toString().replaceAll('"', '\\"')}"';
  }
  if (object is num || object is bool) {
    return object.toString();
  }
  if (object is List) {
    return object.map((e) => serialize(e)).toList().toString();
  }
  if (object is Map) {
    return Map.fromEntries(object.entries.map(
            (e) => MapEntry(serialize(e.key.toString()), serialize(e.value))))
        .toString();
  }
  if (object is Set) {
    return object.map((e) => serialize(e)).toList().toString();
  }
  if (object is Iterable) {
    return object.map((e) => serialize(e)).toList().toString();
  }
  return '';
}
