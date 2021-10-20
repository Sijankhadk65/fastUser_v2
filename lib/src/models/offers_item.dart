import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'offers_item.g.dart';

abstract class OffersItem implements Built<OffersItem, OffersItemBuilder> {
  String? get createdAt;
  bool? get isActive;
  String? get photoURI;
  String? get vendor;
  int? get price;
  String? get description;
  String? get name;

  OffersItem._();
  factory OffersItem([updates(OffersItemBuilder b)]) = _$OffersItem;
  static Serializer<OffersItem> get serializer => _$offersItemSerializer;
}

OffersItem parseToOffersItem(Object? json) {
  return jsonSerializer.deserializeWith(OffersItem.serializer, json)!;
}
