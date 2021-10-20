import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import '../models/serializer.dart';

part 'vendor.g.dart';

abstract class Vendor implements Built<Vendor, VendorBuilder> {
  String? get name;

  String? get photoURI;

  String? get closeTime;

  String? get openTime;

  int? get minOrder;

  String? get physicalLocation;

  double? get lat;

  double? get lang;

  double? get averageRating;

  BuiltList<String>? get tags;

  BuiltList<String>? get categories;

  bool? get isBusy;

  bool? get isAway;

  bool? get isFeatured;

  bool? get isNight;

  String? get logoURL;

  String? get id;

  factory Vendor([void Function(VendorBuilder) updates]) = _$Vendor;
  Vendor._();
  static Serializer<Vendor> get serializer => _$vendorSerializer;
}

Vendor parseJsonToVendor(Object? json) {
  return jsonSerializer.deserializeWith(Vendor.serializer, json)!;
}
