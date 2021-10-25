import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import '../models/serializer.dart';
import '../models/user.dart';

part 'order_ref.g.dart';

abstract class OrderRef implements Built<OrderRef, OrderRefBuilder> {
  double? get totalCost;

  FastUser? get user;

  String? get refID;

  double? get deliveryCharge;

  String? get createdAt;

  BuiltList<String>? get status;

  BuiltList<String>? get vendors;

  String? get physicalLocation;

  FastUser? get isAssignedTo;

  double? get lat;

  double? get lang;

  BuiltList<String>? get promoCodes;
  OrderRef._();
  factory OrderRef([updates(OrderRefBuilder b)]) = _$OrderRef;
  static Serializer<OrderRef> get serializer => _$orderRefSerializer;
}

OrderRef parseJsonToOrderRef(Object? json) =>
    jsonSerializer.deserializeWith(OrderRef.serializer, json)!;
