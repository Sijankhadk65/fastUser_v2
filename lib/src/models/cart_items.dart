import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import './item.dart';

import './serializer.dart';

part 'cart_items.g.dart';

abstract class CartItem implements Built<CartItem, CartItemBuilder> {
  String? get name;
  int? get price;
  int? get totalPrice;
  int? get quantity;
  String? get photoURI;
  CartItem._();
  factory CartItem([Function(CartItemBuilder b) updates]) = _$CartItem;
  static Serializer<CartItem> get serializer => _$cartItemSerializer;
  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "quantity": quantity,
        "totalPrice": totalPrice,
        "photoURI": photoURI,
      };
}

CartItem? parseToCartItem(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(CartItem.serializer, json);
}

CartItem? newFromItemModel(MenuItem item) {
  var itemJson = item.toNewMenuItemJson();
  return jsonSerializer.deserializeWith(CartItem.serializer, itemJson);
}
