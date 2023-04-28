import 'dart:mirrors';

String serialize(dynamic object) {
  if (object == null) return '';
  if (object is String || object is num || object is bool) {
    return '"${object.toString()}"';
  }
  if (object is List) {
    return object.map((e) => serialize(e)).toList().toString();
  }
  if (object is Map) {
    return Map.fromEntries(object.entries
            .map((e) => MapEntry('"${e.key.toString()}"', serialize(e.value))))
        .toString();
  }
  if (object is Set) {
    return object.map((e) => serialize(e)).toList().toString();
  }
  if (object is Iterable) {
    return object.map((e) => serialize(e)).toList().toString();
  }

  Map<String, dynamic> result = {};

  InstanceMirror instanceMirror = reflect(object);
  ClassMirror classMirror = instanceMirror.type;
  classMirror.declarations.forEach((Symbol key, DeclarationMirror value) {
    if (value is VariableMirror && !value.isStatic) {
      String fieldName = MirrorSystem.getName(key);
      dynamic fieldValue = instanceMirror.getField(key).reflectee;
      result[fieldName] = serialize(fieldValue);
    }
  });

  return result.toString();
}
