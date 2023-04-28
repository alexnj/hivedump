import 'package:hivedump/serialize.dart';
import 'package:test/test.dart';

void main() {
  test('serializes simple types', () {
    expect(serialize(null), equals(''));
    expect(serialize('hello'), equals('"hello"'));
    expect(serialize(42), equals('42'));
    expect(serialize(true), equals('true'));
  });

  test('serializes lists', () {
    expect(serialize([1, 2, 3]), equals('[1, 2, 3]'));
    expect(serialize(['a', 'b', 'c']), equals('["a", "b", "c"]'));
    expect(serialize([true, false]), equals('[true, false]'));
  });

  test('serializes sets', () {
    expect(serialize(<int>{1, 2, 3}), equals('[1, 2, 3]'));
    expect(serialize(<String>{'a', 'b', 'c'}), equals('["a", "b", "c"]'));
    expect(serialize(<bool>{true, false}), equals('[true, false]'));
  });

  test('serializes maps', () {
    expect(serialize({'a': 1, 'b': 2}), equals('{"a": 1, "b": 2}'));
    expect(serialize({1: 'a', 2: 'b'}), equals('{"1": "a", "2": "b"}'));
    expect(serialize({true: 1, false: 0}), equals('{"true": 1, "false": 0}'));
  });

  test('serializes complex objects', () {
    var obj = MyClass('foo', 42);
    expect(serialize(obj), equals('{"foo": "foo", "bar": 42}'));
  });
}

class MyClass {
  String foo;
  int bar;

  MyClass(this.foo, this.bar);
}
