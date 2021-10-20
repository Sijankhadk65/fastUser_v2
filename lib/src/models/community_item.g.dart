// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CommunityItem> _$communityItemSerializer =
    new _$CommunityItemSerializer();

class _$CommunityItemSerializer implements StructuredSerializer<CommunityItem> {
  @override
  final Iterable<Type> types = const [CommunityItem, _$CommunityItem];
  @override
  final String wireName = 'CommunityItem';

  @override
  Iterable<Object?> serialize(Serializers serializers, CommunityItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.city;
    if (value != null) {
      result
        ..add('city')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.closeTime;
    if (value != null) {
      result
        ..add('closeTime')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoURI;
    if (value != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.physicalLocation;
    if (value != null) {
      result
        ..add('physicalLocation')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.categories;
    if (value != null) {
      result
        ..add('categories')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  CommunityItem deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommunityItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'closeTime':
          result.closeTime = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'physicalLocation':
          result.physicalLocation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'categories':
          result.categories.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$CommunityItem extends CommunityItem {
  @override
  final String? title;
  @override
  final String? city;
  @override
  final String? closeTime;
  @override
  final String? description;
  @override
  final String? photoURI;
  @override
  final String? physicalLocation;
  @override
  final BuiltList<String>? categories;

  factory _$CommunityItem([void Function(CommunityItemBuilder)? updates]) =>
      (new CommunityItemBuilder()..update(updates)).build();

  _$CommunityItem._(
      {this.title,
      this.city,
      this.closeTime,
      this.description,
      this.photoURI,
      this.physicalLocation,
      this.categories})
      : super._();

  @override
  CommunityItem rebuild(void Function(CommunityItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommunityItemBuilder toBuilder() => new CommunityItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommunityItem &&
        title == other.title &&
        city == other.city &&
        closeTime == other.closeTime &&
        description == other.description &&
        photoURI == other.photoURI &&
        physicalLocation == other.physicalLocation &&
        categories == other.categories;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, title.hashCode), city.hashCode),
                        closeTime.hashCode),
                    description.hashCode),
                photoURI.hashCode),
            physicalLocation.hashCode),
        categories.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CommunityItem')
          ..add('title', title)
          ..add('city', city)
          ..add('closeTime', closeTime)
          ..add('description', description)
          ..add('photoURI', photoURI)
          ..add('physicalLocation', physicalLocation)
          ..add('categories', categories))
        .toString();
  }
}

class CommunityItemBuilder
    implements Builder<CommunityItem, CommunityItemBuilder> {
  _$CommunityItem? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _closeTime;
  String? get closeTime => _$this._closeTime;
  set closeTime(String? closeTime) => _$this._closeTime = closeTime;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _photoURI;
  String? get photoURI => _$this._photoURI;
  set photoURI(String? photoURI) => _$this._photoURI = photoURI;

  String? _physicalLocation;
  String? get physicalLocation => _$this._physicalLocation;
  set physicalLocation(String? physicalLocation) =>
      _$this._physicalLocation = physicalLocation;

  ListBuilder<String>? _categories;
  ListBuilder<String> get categories =>
      _$this._categories ??= new ListBuilder<String>();
  set categories(ListBuilder<String>? categories) =>
      _$this._categories = categories;

  CommunityItemBuilder();

  CommunityItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _city = $v.city;
      _closeTime = $v.closeTime;
      _description = $v.description;
      _photoURI = $v.photoURI;
      _physicalLocation = $v.physicalLocation;
      _categories = $v.categories?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommunityItem other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CommunityItem;
  }

  @override
  void update(void Function(CommunityItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CommunityItem build() {
    _$CommunityItem _$result;
    try {
      _$result = _$v ??
          new _$CommunityItem._(
              title: title,
              city: city,
              closeTime: closeTime,
              description: description,
              photoURI: photoURI,
              physicalLocation: physicalLocation,
              categories: _categories?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'categories';
        _categories?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CommunityItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
