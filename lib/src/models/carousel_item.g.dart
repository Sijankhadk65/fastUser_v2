// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CarouselItem> _$carouselItemSerializer =
    new _$CarouselItemSerializer();

class _$CarouselItemSerializer implements StructuredSerializer<CarouselItem> {
  @override
  final Iterable<Type> types = const [CarouselItem, _$CarouselItem];
  @override
  final String wireName = 'CarouselItem';

  @override
  Iterable<Object?> serialize(Serializers serializers, CarouselItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.carouselID;
    if (value != null) {
      result
        ..add('carouselID')
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
    value = object.isInteractive;
    if (value != null) {
      result
        ..add('isInteractive')
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
    value = object.vendorName;
    if (value != null) {
      result
        ..add('vendorName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.minOrder;
    if (value != null) {
      result
        ..add('minOrder')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.itemCode;
    if (value != null) {
      result
        ..add('itemCode')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  CarouselItem deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CarouselItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'carouselID':
          result.carouselID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isActive':
          result.isActive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'isInteractive':
          result.isInteractive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'vendorName':
          result.vendorName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'minOrder':
          result.minOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'itemCode':
          result.itemCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$CarouselItem extends CarouselItem {
  @override
  final String? carouselID;
  @override
  final bool? isActive;
  @override
  final bool? isInteractive;
  @override
  final String? photoURI;
  @override
  final String? vendorName;
  @override
  final int? minOrder;
  @override
  final String? itemCode;

  factory _$CarouselItem([void Function(CarouselItemBuilder)? updates]) =>
      (new CarouselItemBuilder()..update(updates)).build();

  _$CarouselItem._(
      {this.carouselID,
      this.isActive,
      this.isInteractive,
      this.photoURI,
      this.vendorName,
      this.minOrder,
      this.itemCode})
      : super._();

  @override
  CarouselItem rebuild(void Function(CarouselItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CarouselItemBuilder toBuilder() => new CarouselItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CarouselItem &&
        carouselID == other.carouselID &&
        isActive == other.isActive &&
        isInteractive == other.isInteractive &&
        photoURI == other.photoURI &&
        vendorName == other.vendorName &&
        minOrder == other.minOrder &&
        itemCode == other.itemCode;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, carouselID.hashCode), isActive.hashCode),
                        isInteractive.hashCode),
                    photoURI.hashCode),
                vendorName.hashCode),
            minOrder.hashCode),
        itemCode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CarouselItem')
          ..add('carouselID', carouselID)
          ..add('isActive', isActive)
          ..add('isInteractive', isInteractive)
          ..add('photoURI', photoURI)
          ..add('vendorName', vendorName)
          ..add('minOrder', minOrder)
          ..add('itemCode', itemCode))
        .toString();
  }
}

class CarouselItemBuilder
    implements Builder<CarouselItem, CarouselItemBuilder> {
  _$CarouselItem? _$v;

  String? _carouselID;
  String? get carouselID => _$this._carouselID;
  set carouselID(String? carouselID) => _$this._carouselID = carouselID;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  bool? _isInteractive;
  bool? get isInteractive => _$this._isInteractive;
  set isInteractive(bool? isInteractive) =>
      _$this._isInteractive = isInteractive;

  String? _photoURI;
  String? get photoURI => _$this._photoURI;
  set photoURI(String? photoURI) => _$this._photoURI = photoURI;

  String? _vendorName;
  String? get vendorName => _$this._vendorName;
  set vendorName(String? vendorName) => _$this._vendorName = vendorName;

  int? _minOrder;
  int? get minOrder => _$this._minOrder;
  set minOrder(int? minOrder) => _$this._minOrder = minOrder;

  String? _itemCode;
  String? get itemCode => _$this._itemCode;
  set itemCode(String? itemCode) => _$this._itemCode = itemCode;

  CarouselItemBuilder();

  CarouselItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _carouselID = $v.carouselID;
      _isActive = $v.isActive;
      _isInteractive = $v.isInteractive;
      _photoURI = $v.photoURI;
      _vendorName = $v.vendorName;
      _minOrder = $v.minOrder;
      _itemCode = $v.itemCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CarouselItem other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CarouselItem;
  }

  @override
  void update(void Function(CarouselItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CarouselItem build() {
    final _$result = _$v ??
        new _$CarouselItem._(
            carouselID: carouselID,
            isActive: isActive,
            isInteractive: isInteractive,
            photoURI: photoURI,
            vendorName: vendorName,
            minOrder: minOrder,
            itemCode: itemCode);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
