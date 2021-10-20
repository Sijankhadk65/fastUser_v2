import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fast_app_v2_1/src/models/add_on.dart';
import 'package:fast_app_v2_1/src/models/varient.dart';

import './serializer.dart';

part 'item.g.dart';

abstract class MenuItem implements Built<MenuItem, MenuItemBuilder> {
  String? get category;
  BuiltList<AddOn>? get addOns;
  BuiltList<Varient>? get varients;
  String? get createdAt;
  String? get name;
  String? get photoURI;
  int? get price;
  bool? get isAvailable;
  bool? get isHotAndNew;
  bool? get isFeatured;
  String? get description;
  String? get vendor;
  double? get increaseBy;
  String? get unit;

  MenuItem._();
  factory MenuItem([Function(MenuItemBuilder b) updates]) = _$MenuItem;

  static Serializer<MenuItem> get serializer => _$menuItemSerializer;

  Map<String, dynamic> toNewMenuItemJson() => {
        "name": name,
        "price": price,
        "quantity": 1,
        "totalPrice": price,
        "photoURI": photoURI,
      };
}

MenuItem parseToMenuItemModel(Object? json) {
  return jsonSerializer.deserializeWith(MenuItem.serializer, json)!;
}
