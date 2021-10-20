import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fast_app_v2_1/src/models/user_location.dart';
import '../models/serializer.dart';

part 'user.g.dart';

abstract class FastUser implements Built<FastUser, FastUserBuilder> {
  String? get email;

  String? get name;

  String? get photoURI;

  int? get phoneNumber;

  UserLocation? get home;

  UserLocation? get office;

  bool? get isVerified;

  BuiltList<String>? get promoCodes;

  factory FastUser([void Function(FastUserBuilder) updates]) = _$FastUser;
  FastUser._();
  static Serializer<FastUser> get serializer => _$fastUserSerializer;
}

FastUser parseJsonToUser(Object? json) {
  return jsonSerializer.deserializeWith(FastUser.serializer, json)!;
}

Map<String, dynamic> convertUserToJson(FastUser user) =>
    {"name": user.name, "email": user.email, "photoURI": user.photoURI};
