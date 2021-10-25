import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'cart_items.dart';
import 'serializer.dart';

part 'online_order.g.dart';

abstract class OnlineOrder implements Built<OnlineOrder, OnlineOrderBuilder> {
  double? get totalPrice;
  String? get refID;
  double? get cartLength;
  BuiltList<String>? get status;
  String? get createdAt;
  String? get vendor;
  String? get vendorName;
  int? get minOrder;
  BuiltList<CartItem>? get items;

  OnlineOrder._();
  factory OnlineOrder([updates(OnlineOrderBuilder b)]) = _$OnlineOrder;
  static Serializer<OnlineOrder> get serializer => _$onlineOrderSerializer;
}

OnlineOrder parseJsonToOnlineOrder(Object? json) =>
    jsonSerializer.deserializeWith(OnlineOrder.serializer, json)!;

Map<String, dynamic> onlineOrderToJson(OnlineOrder order) => {
      "totalPrice": order.totalPrice,
      "cartLength": order.cartLength,
      "status": order.status?.toList(),
      "createdAt": order.createdAt,
      "vendor": order.vendor,
      "vendorName": order.vendorName,
      "items": order.items?.toList().map((e) => e.toJson()).toList(),
    };
