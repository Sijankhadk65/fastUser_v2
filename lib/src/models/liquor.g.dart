// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquor.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Liquor> _$liquorSerializer = new _$LiquorSerializer();

class _$LiquorSerializer implements StructuredSerializer<Liquor> {
  @override
  final Iterable<Type> types = const [Liquor, _$Liquor];
  @override
  final String wireName = 'Liquor';

  @override
  Iterable<Object?> serialize(Serializers serializers, Liquor object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'photoURI',
      serializers.serialize(object.photoURI,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.type;
    if (value != null) {
      result
        ..add('type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
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
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.isAvailable;
    if (value != null) {
      result
        ..add('isAvailable')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.isFeatured;
    if (value != null) {
      result
        ..add('isFeatured')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Liquor deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LiquorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'isAvailable':
          result.isAvailable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isFeatured':
          result.isFeatured = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Liquor extends Liquor {
  @override
  final String? type;
  @override
  final String? createdAt;
  @override
  final String? name;
  @override
  final String photoURI;
  @override
  final int? price;
  @override
  final bool? isAvailable;
  @override
  final bool? isFeatured;
  @override
  final String? description;

  factory _$Liquor([void Function(LiquorBuilder)? updates]) =>
      (new LiquorBuilder()..update(updates)).build();

  _$Liquor._(
      {this.type,
      this.createdAt,
      this.name,
      required this.photoURI,
      this.price,
      this.isAvailable,
      this.isFeatured,
      this.description})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(photoURI, 'Liquor', 'photoURI');
  }

  @override
  Liquor rebuild(void Function(LiquorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LiquorBuilder toBuilder() => new LiquorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Liquor &&
        type == other.type &&
        createdAt == other.createdAt &&
        name == other.name &&
        photoURI == other.photoURI &&
        price == other.price &&
        isAvailable == other.isAvailable &&
        isFeatured == other.isFeatured &&
        description == other.description;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, type.hashCode), createdAt.hashCode),
                            name.hashCode),
                        photoURI.hashCode),
                    price.hashCode),
                isAvailable.hashCode),
            isFeatured.hashCode),
        description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Liquor')
          ..add('type', type)
          ..add('createdAt', createdAt)
          ..add('name', name)
          ..add('photoURI', photoURI)
          ..add('price', price)
          ..add('isAvailable', isAvailable)
          ..add('isFeatured', isFeatured)
          ..add('description', description))
        .toString();
  }
}

class LiquorBuilder implements Builder<Liquor, LiquorBuilder> {
  _$Liquor? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _photoURI;
  String? get photoURI => _$this._photoURI;
  set photoURI(String? photoURI) => _$this._photoURI = photoURI;

  int? _price;
  int? get price => _$this._price;
  set price(int? price) => _$this._price = price;

  bool? _isAvailable;
  bool? get isAvailable => _$this._isAvailable;
  set isAvailable(bool? isAvailable) => _$this._isAvailable = isAvailable;

  bool? _isFeatured;
  bool? get isFeatured => _$this._isFeatured;
  set isFeatured(bool? isFeatured) => _$this._isFeatured = isFeatured;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  LiquorBuilder();

  LiquorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _createdAt = $v.createdAt;
      _name = $v.name;
      _photoURI = $v.photoURI;
      _price = $v.price;
      _isAvailable = $v.isAvailable;
      _isFeatured = $v.isFeatured;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Liquor other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Liquor;
  }

  @override
  void update(void Function(LiquorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Liquor build() {
    final _$result = _$v ??
        new _$Liquor._(
            type: type,
            createdAt: createdAt,
            name: name,
            photoURI: BuiltValueNullFieldError.checkNotNull(
                photoURI, 'Liquor', 'photoURI'),
            price: price,
            isAvailable: isAvailable,
            isFeatured: isFeatured,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
