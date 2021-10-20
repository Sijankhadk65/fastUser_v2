import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'carousel_item.g.dart';

abstract class CarouselItem
    implements Built<CarouselItem, CarouselItemBuilder> {
  String? get carouselID;
  bool? get isActive;
  bool? get isInteractive;
  String? get photoURI;
  String? get vendorName;
  int? get minOrder;
  String? get itemCode;
  CarouselItem._();
  factory CarouselItem([Function(CarouselItemBuilder b) updates]) =
      _$CarouselItem;
  static Serializer<CarouselItem> get serializer => _$carouselItemSerializer;
}

parseToCarouselItem(Object? json) {
  return jsonSerializer.deserializeWith(CarouselItem.serializer, json)!;
}
