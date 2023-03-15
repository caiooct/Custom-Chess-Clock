import 'package:custom_chess_clock/data/data_sources/clock_local_data_source.dart';
import 'package:custom_chess_clock/data/models/clock.dart';
import 'package:custom_chess_clock/data/enums/timing_methods_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';

class MockIsarCollection<T> extends Mock implements IsarCollection<T> {}

class MockQueryBuilder<R, S> extends Mock implements QueryBuilder<R, S, QWhere> {}

class MockIsar extends Mock implements Isar {}

class MockQueryBuilderInternal<T> extends Mock implements QueryBuilderInternal<T> {}

class MockQuery<T> extends Mock implements Query<T> {}

class FakeClock extends Fake implements Clock {}

void main() async {
  late MockIsar isar;
  late IsarCollection<Clock> clockCollection;
  late ClockLocalDataSource clockLocalDataSource;
  late QueryBuilder<Clock, Clock, QWhere> clockBuilder;
  late MockQueryBuilderInternal<Clock> mockQueryBuilderInternal;
  late Query<Clock> mockQuery;

  group('ClockLocalDataSource', () {
    setUp(() async {
      registerFallbackValue(FakeClock());
      registerFallbackValue([FakeClock()]);
      await Isar.initializeIsarCore(download: true);
      isar = MockIsar();
      clockLocalDataSource = ClockLocalDataSource(isar);
      clockCollection = MockIsarCollection<Clock>();
      mockQueryBuilderInternal = MockQueryBuilderInternal<Clock>();
      clockBuilder = QueryBuilder<Clock, Clock, QWhere>(mockQueryBuilderInternal);
      mockQuery = MockQuery<Clock>();
    });

    test('should return empty', () async {
      final list = <Clock>[];
      when(() => isar.clocks).thenReturn(clockCollection);
      when(() => clockCollection.where()).thenReturn(clockBuilder);
      when(() => clockBuilder.build()).thenReturn(mockQuery);
      when(() => mockQuery.findAll()).thenAnswer((_) async => list);

      var result = await clockLocalDataSource.getAll();
      expect(result, isEmpty);
    });

    test('should not return empty', () async {
      final list = <Clock>[
        Clock.sec(
          "Blitz",
          const TimeControl(
            timeInSeconds: 60,
            timingMethod: TimingMethodEnum.fischer,
            incrementInSeconds: 0,
          ),
          const TimeControl(
            timeInSeconds: 60,
            timingMethod: TimingMethodEnum.fischer,
            incrementInSeconds: 0,
          ),
        )
      ];
      when(() => isar.clocks).thenReturn(clockCollection);
      when(() => clockCollection.where()).thenReturn(clockBuilder);
      when(() => clockBuilder.build()).thenReturn(mockQuery);
      when(() => mockQuery.findAll()).thenAnswer((_) async => list);

      var result = await clockLocalDataSource.getAll();
      expect(result, isNotEmpty);
      expect(result, isA<List<Clock>>());
    });

    // test('should successfully insert', () {
    //   when(() => isar.clocks).thenReturn(clockCollection);
    //   when(() => isar.writeTxn(any())).thenAnswer((realInvocation) {
    //     final ee = realInvocation.positionalArguments[0] as Function();
    //     return ee();
    //   });
    //   when(() => clockCollection.put(any())).thenAnswer((_) async => 1);
    //   when(() => clockCollection.putAll(any())).thenAnswer((_) async => [1]);
    //
    //   when(() => clockCollection.isar).thenReturn(isar);
    //   clockLocalDataSource.insert(
    //     Clock.sec(
    //       "Blitz",
    //       const TimeControl(
    //         timeInSeconds: 60,
    //         timingMethod: TimingMethodEnum.fischer,
    //         incrementInSeconds: 0,
    //       ),
    //       const TimeControl(
    //         timeInSeconds: 60,
    //         timingMethod: TimingMethodEnum.fischer,
    //         incrementInSeconds: 0,
    //       ),
    //     ),
    //   );
    // });
  });
}
