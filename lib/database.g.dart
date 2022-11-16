// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Timer extends DataClass implements Insertable<Timer> {
  final int id;
  final DateTime start;
  final DateTime? stop;
  const Timer({required this.id, required this.start, this.stop});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['start'] = Variable<DateTime>(start);
    if (!nullToAbsent || stop != null) {
      map['stop'] = Variable<DateTime>(stop);
    }
    return map;
  }

  TimersCompanion toCompanion(bool nullToAbsent) {
    return TimersCompanion(
      id: Value(id),
      start: Value(start),
      stop: stop == null && nullToAbsent ? const Value.absent() : Value(stop),
    );
  }

  factory Timer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Timer(
      id: serializer.fromJson<int>(json['id']),
      start: serializer.fromJson<DateTime>(json['start']),
      stop: serializer.fromJson<DateTime?>(json['stop']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'start': serializer.toJson<DateTime>(start),
      'stop': serializer.toJson<DateTime?>(stop),
    };
  }

  Timer copyWith(
          {int? id,
          DateTime? start,
          Value<DateTime?> stop = const Value.absent()}) =>
      Timer(
        id: id ?? this.id,
        start: start ?? this.start,
        stop: stop.present ? stop.value : this.stop,
      );
  @override
  String toString() {
    return (StringBuffer('Timer(')
          ..write('id: $id, ')
          ..write('start: $start, ')
          ..write('stop: $stop')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, start, stop);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Timer &&
          other.id == this.id &&
          other.start == this.start &&
          other.stop == this.stop);
}

class TimersCompanion extends UpdateCompanion<Timer> {
  final Value<int> id;
  final Value<DateTime> start;
  final Value<DateTime?> stop;
  const TimersCompanion({
    this.id = const Value.absent(),
    this.start = const Value.absent(),
    this.stop = const Value.absent(),
  });
  TimersCompanion.insert({
    this.id = const Value.absent(),
    required DateTime start,
    this.stop = const Value.absent(),
  }) : start = Value(start);
  static Insertable<Timer> custom({
    Expression<int>? id,
    Expression<DateTime>? start,
    Expression<DateTime>? stop,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (start != null) 'start': start,
      if (stop != null) 'stop': stop,
    });
  }

  TimersCompanion copyWith(
      {Value<int>? id, Value<DateTime>? start, Value<DateTime?>? stop}) {
    return TimersCompanion(
      id: id ?? this.id,
      start: start ?? this.start,
      stop: stop ?? this.stop,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (stop.present) {
      map['stop'] = Variable<DateTime>(stop.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimersCompanion(')
          ..write('id: $id, ')
          ..write('start: $start, ')
          ..write('stop: $stop')
          ..write(')'))
        .toString();
  }
}

class $TimersTable extends Timers with TableInfo<$TimersTable, Timer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
      'start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _stopMeta = const VerificationMeta('stop');
  @override
  late final GeneratedColumn<DateTime> stop = GeneratedColumn<DateTime>(
      'stop', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, start, stop];
  @override
  String get aliasedName => _alias ?? 'timers';
  @override
  String get actualTableName => 'timers';
  @override
  VerificationContext validateIntegrity(Insertable<Timer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('stop')) {
      context.handle(
          _stopMeta, stop.isAcceptableOrUnknown(data['stop']!, _stopMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Timer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Timer(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      start: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start'])!,
      stop: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}stop']),
    );
  }

  @override
  $TimersTable createAlias(String alias) {
    return $TimersTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $TimersTable timers = $TimersTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [timers];
}
