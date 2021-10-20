import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializer.dart';

part 'community_item.g.dart';

abstract class CommunityItem
    implements Built<CommunityItem, CommunityItemBuilder> {
  String? get title;
  String? get city;
  String? get closeTime;
  String? get description;
  String? get photoURI;
  String? get physicalLocation;
  BuiltList<String>? get categories;

  CommunityItem._();
  factory CommunityItem([Function(CommunityItemBuilder b) updates]) =
      _$CommunityItem;

  static Serializer<CommunityItem> get serializer => _$communityItemSerializer;

  Map<String, dynamic> toNewCommunityItemJson() => {
        "title": title,
        "city": city,
        "closeTime": closeTime,
        "description": description,
        "photoURI": photoURI,
        "physicalLocation": physicalLocation,
        "categories": categories
      };
}

CommunityItem parseToCommunityItemModel(Object? json) {
  return jsonSerializer.deserializeWith(CommunityItem.serializer, json)!;
}
