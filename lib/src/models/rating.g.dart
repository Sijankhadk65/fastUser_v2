// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Rating> _$ratingSerializer = new _$RatingSerializer();

class _$RatingSerializer implements StructuredSerializer<Rating> {
  @override
  final Iterable<Type> types = const [Rating, _$Rating];
  @override
  final String wireName = 'Rating';

  @override
  Iterable<Object?> serialize(Serializers serializers, Rating object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.comment;
    if (value != null) {
      result
        ..add('comment')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.user;
    if (value != null) {
      result
        ..add('user')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(FastUser)));
    }
    value = object.rating;
    if (value != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Rating deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RatingBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'comment':
          result.comment = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(FastUser))! as FastUser);
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Rating extends Rating {
  @override
  final String? comment;
  @override
  final FastUser? user;
  @override
  final double? rating;
  @override
  final String? createdAt;

  factory _$Rating([void Function(RatingBuilder)? updates]) =>
      (new RatingBuilder()..update(updates)).build();

  _$Rating._({this.comment, this.user, this.rating, this.createdAt})
      : super._();

  @override
  Rating rebuild(void Function(RatingBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RatingBuilder toBuilder() => new RatingBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Rating &&
        comment == other.comment &&
        user == other.user &&
        rating == other.rating &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, comment.hashCode), user.hashCode), rating.hashCode),
        createdAt.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Rating')
          ..add('comment', comment)
          ..add('user', user)
          ..add('rating', rating)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class RatingBuilder implements Builder<Rating, RatingBuilder> {
  _$Rating? _$v;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  FastUserBuilder? _user;
  FastUserBuilder get user => _$this._user ??= new FastUserBuilder();
  set user(FastUserBuilder? user) => _$this._user = user;

  double? _rating;
  double? get rating => _$this._rating;
  set rating(double? rating) => _$this._rating = rating;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  RatingBuilder();

  RatingBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _comment = $v.comment;
      _user = $v.user?.toBuilder();
      _rating = $v.rating;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Rating other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Rating;
  }

  @override
  void update(void Function(RatingBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Rating build() {
    _$Rating _$result;
    try {
      _$result = _$v ??
          new _$Rating._(
              comment: comment,
              user: _user?.build(),
              rating: rating,
              createdAt: createdAt);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Rating', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
