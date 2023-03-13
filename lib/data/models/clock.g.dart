// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetClockCollection on Isar {
  IsarCollection<Clock> get clocks => this.collection();
}

const ClockSchema = CollectionSchema(
  name: r'Clock',
  id: -883707081807623633,
  properties: {
    r'black': PropertySchema(
      id: 0,
      name: r'black',
      type: IsarType.object,
      target: r'TimeControl',
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'white': PropertySchema(
      id: 2,
      name: r'white',
      type: IsarType.object,
      target: r'TimeControl',
    )
  },
  estimateSize: _clockEstimateSize,
  serialize: _clockSerialize,
  deserialize: _clockDeserialize,
  deserializeProp: _clockDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'TimeControl': TimeControlSchema},
  getId: _clockGetId,
  getLinks: _clockGetLinks,
  attach: _clockAttach,
  version: '3.0.5',
);

int _clockEstimateSize(
  Clock object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      TimeControlSchema.estimateSize(
          object.black, allOffsets[TimeControl]!, allOffsets);
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 +
      TimeControlSchema.estimateSize(
          object.white, allOffsets[TimeControl]!, allOffsets);
  return bytesCount;
}

void _clockSerialize(
  Clock object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<TimeControl>(
    offsets[0],
    allOffsets,
    TimeControlSchema.serialize,
    object.black,
  );
  writer.writeString(offsets[1], object.name);
  writer.writeObject<TimeControl>(
    offsets[2],
    allOffsets,
    TimeControlSchema.serialize,
    object.white,
  );
}

Clock _clockDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Clock();
  object.black = reader.readObjectOrNull<TimeControl>(
        offsets[0],
        TimeControlSchema.deserialize,
        allOffsets,
      ) ??
      TimeControl();
  object.id = id;
  object.name = reader.readString(offsets[1]);
  object.white = reader.readObjectOrNull<TimeControl>(
        offsets[2],
        TimeControlSchema.deserialize,
        allOffsets,
      ) ??
      TimeControl();
  return object;
}

P _clockDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<TimeControl>(
            offset,
            TimeControlSchema.deserialize,
            allOffsets,
          ) ??
          TimeControl()) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<TimeControl>(
            offset,
            TimeControlSchema.deserialize,
            allOffsets,
          ) ??
          TimeControl()) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _clockGetId(Clock object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _clockGetLinks(Clock object) {
  return [];
}

void _clockAttach(IsarCollection<dynamic> col, Id id, Clock object) {
  object.id = id;
}

extension ClockQueryWhereSort on QueryBuilder<Clock, Clock, QWhere> {
  QueryBuilder<Clock, Clock, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ClockQueryWhere on QueryBuilder<Clock, Clock, QWhereClause> {
  QueryBuilder<Clock, Clock, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Clock, Clock, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Clock, Clock, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Clock, Clock, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ClockQueryFilter on QueryBuilder<Clock, Clock, QFilterCondition> {
  QueryBuilder<Clock, Clock, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension ClockQueryObject on QueryBuilder<Clock, Clock, QFilterCondition> {
  QueryBuilder<Clock, Clock, QAfterFilterCondition> black(
      FilterQuery<TimeControl> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'black');
    });
  }

  QueryBuilder<Clock, Clock, QAfterFilterCondition> white(
      FilterQuery<TimeControl> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'white');
    });
  }
}

extension ClockQueryLinks on QueryBuilder<Clock, Clock, QFilterCondition> {}

extension ClockQuerySortBy on QueryBuilder<Clock, Clock, QSortBy> {
  QueryBuilder<Clock, Clock, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Clock, Clock, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ClockQuerySortThenBy on QueryBuilder<Clock, Clock, QSortThenBy> {
  QueryBuilder<Clock, Clock, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Clock, Clock, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Clock, Clock, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Clock, Clock, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ClockQueryWhereDistinct on QueryBuilder<Clock, Clock, QDistinct> {
  QueryBuilder<Clock, Clock, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension ClockQueryProperty on QueryBuilder<Clock, Clock, QQueryProperty> {
  QueryBuilder<Clock, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Clock, TimeControl, QQueryOperations> blackProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'black');
    });
  }

  QueryBuilder<Clock, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Clock, TimeControl, QQueryOperations> whiteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'white');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

const TimeControlSchema = Schema(
  name: r'TimeControl',
  id: 2437759545463724430,
  properties: {
    r'incrementInSeconds': PropertySchema(
      id: 0,
      name: r'incrementInSeconds',
      type: IsarType.long,
    ),
    r'timeInSeconds': PropertySchema(
      id: 1,
      name: r'timeInSeconds',
      type: IsarType.long,
    ),
    r'timingMethod': PropertySchema(
      id: 2,
      name: r'timingMethod',
      type: IsarType.byte,
      enumMap: _TimeControltimingMethodEnumValueMap,
    )
  },
  estimateSize: _timeControlEstimateSize,
  serialize: _timeControlSerialize,
  deserialize: _timeControlDeserialize,
  deserializeProp: _timeControlDeserializeProp,
);

int _timeControlEstimateSize(
  TimeControl object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _timeControlSerialize(
  TimeControl object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.incrementInSeconds);
  writer.writeLong(offsets[1], object.timeInSeconds);
  writer.writeByte(offsets[2], object.timingMethod.index);
}

TimeControl _timeControlDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimeControl(
    incrementInSeconds: reader.readLongOrNull(offsets[0]) ?? 0,
    timeInSeconds: reader.readLongOrNull(offsets[1]) ?? 0,
    timingMethod: _TimeControltimingMethodValueEnumMap[
            reader.readByteOrNull(offsets[2])] ??
        TimingMethodEnum.fischer,
  );
  return object;
}

P _timeControlDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (_TimeControltimingMethodValueEnumMap[
              reader.readByteOrNull(offset)] ??
          TimingMethodEnum.fischer) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _TimeControltimingMethodEnumValueMap = {
  'delay': 0,
  'bronstein': 1,
  'fischer': 2,
};
const _TimeControltimingMethodValueEnumMap = {
  0: TimingMethodEnum.delay,
  1: TimingMethodEnum.bronstein,
  2: TimingMethodEnum.fischer,
};

extension TimeControlQueryFilter
    on QueryBuilder<TimeControl, TimeControl, QFilterCondition> {
  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      incrementInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'incrementInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      incrementInSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'incrementInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      incrementInSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'incrementInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      incrementInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'incrementInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      timeInSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      timeInSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      timeInSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeInSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      timeInSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeInSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      timingMethodEqualTo(TimingMethodEnum value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timingMethod',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      timingMethodGreaterThan(
    TimingMethodEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timingMethod',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      timingMethodLessThan(
    TimingMethodEnum value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timingMethod',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeControl, TimeControl, QAfterFilterCondition>
      timingMethodBetween(
    TimingMethodEnum lower,
    TimingMethodEnum upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timingMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimeControlQueryObject
    on QueryBuilder<TimeControl, TimeControl, QFilterCondition> {}
