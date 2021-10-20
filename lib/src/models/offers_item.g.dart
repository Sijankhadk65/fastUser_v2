// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OffersItem> _$offersItemSerializer = new _$OffersItemSerializer();

class _$OffersItemSerializer implements StructuredSerializer<OffersItem> {
  @override
  final Iterable<Type> types = const [OffersItem, _$OffersItem];
  @override
  final String wireName = 'OffersItem';

  @override
  Iterable<Object?> serialize(Serializers serializers, OffersItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isActive;
    if (value != null) {
      result
        ..add('isActive')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.photoURI;
    if (value != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.vendor;
    if (value != null) {
      result
        ..add('vendor')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OffersItem deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OffersItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isActive':
          result.isActive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'vendor':
          result.vendor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$OffersItem extends OffersItem {
  @override
  final String? createdAt;
  @override
  final bool? isActive;
  @override
  final String? photoURI;
  @override
  final String? vendor;
  @override
  final int? price;
  @override
  final String? description;
  @override
  final String? name;

  factory _$OffersItem([void Function(OffersItemBuilder)? updates]) =>
      (new OffersItemBuilder()..update(updates)).build();

  _$OffersItem._(
      {this.createdAt,
      this.isActive,
      this.photoURI,
      this.vendor,
      this.price,
      this.description,
      this.name})
      : super._();

  @override
  OffersItem rebuild(void Function(OffersItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OffersItemBuilder toBuilder() => new OffersItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OffersItem &&
        createdAt == other.createdAt &&
        isActive == other.isActive &&
        photoURI == other.photoURI &&
        vendor == other.vendor &&
        price == other.price &&
        description == other.description &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, createdAt.hashCode), isActive.hashCode),
                        photoURI.hashCode),
                    vendor.hashCode),
                price.hashCode),
            description.hashCode),
        name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OffersItem')
          ..add('createdAt', createdAt)
          ..add('isActive', isActive)
          ..add('photoURI', photoURI)
          ..add('vendor', vendor)
          ..add('price', price)
          ..add('description', description)
          ..add('name', name))
        .toString();
  }
}

class OffersItemBuilder implements Builder<OffersItem, OffersItemBuilder> {
  _$OffersItem? _$v;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  String? _photoURI;
  String? get photoURI => _$this._photoURI;
  set photoURI(String? photoURI) => _$this._photoURI = photoURI;

  String? _vendor;
  String? get vendor => _$this._vendor;
  set vendor(String? vendor) => _$this._vendor = vendor;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  OffersItemBuilder();

  OffersItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createdAt = $v.createdAt;
      _isActive = $v.isActive;
      _photoURI = $v.photoURI;
      _vendor = $v.vendor;
      _price = $v.price;
      _description = $v.description;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OffersItem other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OffersItem;
  }

  @override
  void update(void Function(OffersItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OffersItem build() {
    final _$result = _$v ??
        new _$OffersItem._(
            createdAt: createdAt,
            isActive: isActive,
            photoURI: photoURI,
            vendor: vendor,
            price: price,
            description: description,
            name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
