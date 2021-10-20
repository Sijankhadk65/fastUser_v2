import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'liquor.g.dart';

abstract class Liquor implements Built<Liquor, LiquorBuilder> {
  String? get type;
  String? get createdAt;
  String? get name;
  String get photoURI;
  int? get price;
  bool? get isAvailable;
  bool? get isFeatured;
  String? get description;

  Liquor._();
  factory Liquor([updates(LiquorBuilder b)]) = _$Liquor;

  static Serializer<Liquor> get serializer => _$liquorSerializer;

  Map<String, dynamic> toNewLiquorJson() => {
        "name": this.name,
        "price": this.price,
        "quantity": 1,
        "totalPrice": this.price,
      };
}

Liquor parseToLiquorModel(Object? json) {
  return jsonSerializer.deserializeWith(Liquor.serializer, json)!;
}
