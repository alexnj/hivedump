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
    expect(serialize({'foo': 'bar'}), '{"foo": "bar"}');
  });

  test('serializes nested objects', () {
    expect(
        serialize({
          'name': 'John Doe',
          'age': 30,
          'address': '123 Main Street, Anytown, CA 12345',
          'friends': ['Alice', 'Bob', 'Carol'],
        }),
        '{"name": "John Doe", "age": 30, "address": "123 Main Street, Anytown, CA 12345", "friends": ["Alice", "Bob", "Carol"]}');
  });
}
