import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializer.dart';

part 'promo_code.g.dart';

abstract class PromoCode implements Built<PromoCode, PromoCodeBuilder> {
  String? get validTill;

  BuiltList<String>? get vendors;

  double? get rate;

  String? get createdAt;

  String? get code;
  PromoCode._();
  factory PromoCode([updates(PromoCodeBuilder b)]) = _$PromoCode;
  static Serializer<PromoCode> get serializer => _$promoCodeSerializer;
}

PromoCode parseJsonToPromoCode(Object? json) =>
    jsonSerializer.deserializeWith(PromoCode.serializer, json)!;
