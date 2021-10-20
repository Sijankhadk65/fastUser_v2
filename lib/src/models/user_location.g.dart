// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UserLocation> _$userLocationSerializer =
    new _$UserLocationSerializer();

class _$UserLocationSerializer implements StructuredSerializer<UserLocation> {
  @override
  final Iterable<Type> types = const [UserLocation, _$UserLocation];
  @override
  final String wireName = 'UserLocation';

  @override
  Iterable<Object?> serialize(Serializers serializers, UserLocation object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.lat;
    if (value != null) {
      result
        ..add('lat')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.lang;
    if (value != null) {
      result
        ..add('lang')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.physicalLocation;
    if (value != null) {
      result
        ..add('physicalLocation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UserLocation deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserLocationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'lat':
          result.lat = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'lang':
          result.lang = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'physicalLocation':
          result.physicalLocation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$UserLocation extends UserLocation {
  @override
  final double? lat;
  @override
  final double? lang;
  @override
  final String? physicalLocation;

  factory _$UserLocation([void Function(UserLocationBuilder)? updates]) =>
      (new UserLocationBuilder()..update(updates)).build();

  _$UserLocation._({this.lat, this.lang, this.physicalLocation}) : super._();

  @override
  UserLocation rebuild(void Function(UserLocationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserLocationBuilder toBuilder() => new UserLocationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserLocation &&
        lat == other.lat &&
        lang == other.lang &&
        physicalLocation == other.physicalLocation;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, lat.hashCode), lang.hashCode), physicalLocation.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('UserLocation')
          ..add('lat', lat)
          ..add('lang', lang)
          ..add('physicalLocation', physicalLocation))
        .toString();
  }
}

class UserLocationBuilder
    implements Builder<UserLocation, UserLocationBuilder> {
  _$UserLocation? _$v;

  double? _lat;
  double? get lat => _$this._lat;
  set lat(double? lat) => _$this._lat = lat;

  double? _lang;
  double? get lang => _$this._lang;
  set lang(double? lang) => _$this._lang = lang;

  String? _physicalLocation;
  String? get physicalLocation => _$this._physicalLocation;
  set physicalLocation(String? physicalLocation) =>
      _$this._physicalLocation = physicalLocation;

  UserLocationBuilder();

  UserLocationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _lat = $v.lat;
      _lang = $v.lang;
      _physicalLocation = $v.physicalLocation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserLocation other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UserLocation;
  }

  @override
  void update(void Function(UserLocationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$UserLocation build() {
    final _$result = _$v ??
        new _$UserLocation._(
            lat: lat, lang: lang, physicalLocation: physicalLocation);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
