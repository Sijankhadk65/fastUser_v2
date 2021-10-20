import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'add_on.g.dart';

abstract class AddOn implements Built<AddOn, AddOnBuilder> {
  String? get name;
  int? get price;

  AddOn._();
  factory AddOn([Function(AddOnBuilder b) updates]) = _$AddOn;

  static Serializer<AddOn> get serializer => _$addOnSerializer;

  Map<String, dynamic> toNewAddOnJson() => {
        "name": name,
        "price": price,
      };
}

AddOn? parseToAddOnModel(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(AddOn.serializer, json);
}
