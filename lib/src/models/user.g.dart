// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<FastUser> _$fastUserSerializer = new _$FastUserSerializer();

class _$FastUserSerializer implements StructuredSerializer<FastUser> {
  @override
  final Iterable<Type> types = const [FastUser, _$FastUser];
  @override
  final String wireName = 'FastUser';

  @override
  Iterable<Object?> serialize(Serializers serializers, FastUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoURI;
    if (value != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phoneNumber')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.home;
    if (value != null) {
      result
        ..add('home')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(UserLocation)));
    }
    value = object.office;
    if (value != null) {
      result
        ..add('office')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(UserLocation)));
    }
    value = object.isVerified;
    if (value != null) {
      result
        ..add('isVerified')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.promoCodes;
    if (value != null) {
      result
        ..add('promoCodes')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    return result;
  }

  @override
  FastUser deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new FastUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'phoneNumber':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'home':
          result.home.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserLocation))! as UserLocation);
          break;
        case 'office':
          result.office.replace(serializers.deserialize(value,
              specifiedType: const FullType(UserLocation))! as UserLocation);
          break;
        case 'isVerified':
          result.isVerified = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'promoCodes':
          result.promoCodes.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$FastUser extends FastUser {
  @override
  final String? email;
  @override
  final String? name;
  @override
  final String? photoURI;
  @override
  final int? phoneNumber;
  @override
  final UserLocation? home;
  @override
  final UserLocation? office;
  @override
  final bool? isVerified;
  @override
  final BuiltList<String>? promoCodes;

  factory _$FastUser([void Function(FastUserBuilder)? updates]) =>
      (new FastUserBuilder()..update(updates)).build();

  _$FastUser._(
      {this.email,
      this.name,
      this.photoURI,
      this.phoneNumber,
      this.home,
      this.office,
      this.isVerified,
      this.promoCodes})
      : super._();

  @override
  FastUser rebuild(void Function(FastUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FastUserBuilder toBuilder() => new FastUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FastUser &&
        email == other.email &&
        name == other.name &&
        photoURI == other.photoURI &&
        phoneNumber == other.phoneNumber &&
        home == other.home &&
        office == other.office &&
        isVerified == other.isVerified &&
        promoCodes == other.promoCodes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, email.hashCode), name.hashCode),
                            photoURI.hashCode),
                        phoneNumber.hashCode),
                    home.hashCode),
                office.hashCode),
            isVerified.hashCode),
        promoCodes.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FastUser')
          ..add('email', email)
          ..add('name', name)
          ..add('photoURI', photoURI)
          ..add('phoneNumber', phoneNumber)
          ..add('home', home)
          ..add('office', office)
          ..add('isVerified', isVerified)
          ..add('promoCodes', promoCodes))
        .toString();
  }
}

class FastUserBuilder implements Builder<FastUser, FastUserBuilder> {
  _$FastUser? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _photoURI;
  String? get photoURI => _$this._photoURI;
  set photoURI(String? photoURI) => _$this._photoURI = photoURI;

  int? _phoneNumber;
  int? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(int? phoneNumber) => _$this._phoneNumber = phoneNumber;

  UserLocationBuilder? _home;
  UserLocationBuilder get home => _$this._home ??= new UserLocationBuilder();
  set home(UserLocationBuilder? home) => _$this._home = home;

  UserLocationBuilder? _office;
  UserLocationBuilder get office =>
      _$this._office ??= new UserLocationBuilder();
  set office(UserLocationBuilder? office) => _$this._office = office;

  bool? _isVerified;
  bool? get isVerified => _$this._isVerified;
  set isVerified(bool? isVerified) => _$this._isVerified = isVerified;

  ListBuilder<String>? _promoCodes;
  ListBuilder<String> get promoCodes =>
      _$this._promoCodes ??= new ListBuilder<String>();
  set promoCodes(ListBuilder<String>? promoCodes) =>
      _$this._promoCodes = promoCodes;

  FastUserBuilder();

  FastUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _name = $v.name;
      _photoURI = $v.photoURI;
      _phoneNumber = $v.phoneNumber;
      _home = $v.home?.toBuilder();
      _office = $v.office?.toBuilder();
      _isVerified = $v.isVerified;
      _promoCodes = $v.promoCodes?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FastUser other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FastUser;
  }

  @override
  void update(void Function(FastUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FastUser build() {
    _$FastUser _$result;
    try {
      _$result = _$v ??
          new _$FastUser._(
              email: email,
              name: name,
              photoURI: photoURI,
              phoneNumber: phoneNumber,
              home: _home?.build(),
              office: _office?.build(),
              isVerified: isVerified,
              promoCodes: _promoCodes?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'home';
        _home?.build();
        _$failedField = 'office';
        _office?.build();

        _$failedField = 'promoCodes';
        _promoCodes?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FastUser', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
