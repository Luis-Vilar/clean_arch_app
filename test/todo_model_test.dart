import 'package:clean_arch_app/app/infra/models/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TodoModel', () {
    test('serializes createdAt as ISO 8601 string and restores DateTime', () {
      final createdAt = DateTime.utc(2024, 1, 2, 3, 4, 5, 678);

      final model = TodoModel(
        id: 1,
        title: 'Test',
        todo: 'Description',
        createdAt: createdAt,
        completed: false,
      );

      final map = model.toMap();

      expect(map['createdAt'], equals(createdAt.toIso8601String()));

      final restored = TodoModel.fromMap(map);

      expect(restored.createdAt, equals(createdAt));
    });
  });
}
