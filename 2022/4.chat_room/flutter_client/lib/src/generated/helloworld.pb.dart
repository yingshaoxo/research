///
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

class Empty extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Empty', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'helloworld'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  Empty._() : super();
  factory Empty() => create();
  factory Empty.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Empty.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Empty clone() => Empty()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Empty copyWith(void Function(Empty) updates) => super.copyWith((message) => updates(message as Empty)) as Empty; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Empty create() => Empty._();
  Empty createEmptyInstance() => create();
  static $pb.PbList<Empty> createRepeated() => $pb.PbList<Empty>();
  @$core.pragma('dart2js:noInline')
  static Empty getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Empty>(create);
  static Empty? _defaultInstance;
}

class VoiceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VoiceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'helloworld'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'voice', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  VoiceRequest._() : super();
  factory VoiceRequest({
    $core.String? uuid,
    $fixnum.Int64? timestamp,
    $core.List<$core.int>? voice,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (voice != null) {
      _result.voice = voice;
    }
    return _result;
  }
  factory VoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VoiceRequest clone() => VoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VoiceRequest copyWith(void Function(VoiceRequest) updates) => super.copyWith((message) => updates(message as VoiceRequest)) as VoiceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VoiceRequest create() => VoiceRequest._();
  VoiceRequest createEmptyInstance() => create();
  static $pb.PbList<VoiceRequest> createRepeated() => $pb.PbList<VoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static VoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VoiceRequest>(create);
  static VoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set timestamp($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get voice => $_getN(2);
  @$pb.TagNumber(3)
  set voice($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVoice() => $_has(2);
  @$pb.TagNumber(3)
  void clearVoice() => clearField(3);
}

class VoiceReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'VoiceReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'helloworld'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timestamp')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'voice', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  VoiceReply._() : super();
  factory VoiceReply({
    $core.String? uuid,
    $fixnum.Int64? timestamp,
    $core.List<$core.int>? voice,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (timestamp != null) {
      _result.timestamp = timestamp;
    }
    if (voice != null) {
      _result.voice = voice;
    }
    return _result;
  }
  factory VoiceReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VoiceReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VoiceReply clone() => VoiceReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VoiceReply copyWith(void Function(VoiceReply) updates) => super.copyWith((message) => updates(message as VoiceReply)) as VoiceReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static VoiceReply create() => VoiceReply._();
  VoiceReply createEmptyInstance() => create();
  static $pb.PbList<VoiceReply> createRepeated() => $pb.PbList<VoiceReply>();
  @$core.pragma('dart2js:noInline')
  static VoiceReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VoiceReply>(create);
  static VoiceReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set timestamp($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get voice => $_getN(2);
  @$pb.TagNumber(3)
  set voice($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVoice() => $_has(2);
  @$pb.TagNumber(3)
  void clearVoice() => clearField(3);
}

class CurrentUsersUUIDReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'CurrentUsersUUIDReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'helloworld'), createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..hasRequiredFields = false
  ;

  CurrentUsersUUIDReply._() : super();
  factory CurrentUsersUUIDReply({
    $core.Iterable<$core.String>? uuid,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid.addAll(uuid);
    }
    return _result;
  }
  factory CurrentUsersUUIDReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CurrentUsersUUIDReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CurrentUsersUUIDReply clone() => CurrentUsersUUIDReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CurrentUsersUUIDReply copyWith(void Function(CurrentUsersUUIDReply) updates) => super.copyWith((message) => updates(message as CurrentUsersUUIDReply)) as CurrentUsersUUIDReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static CurrentUsersUUIDReply create() => CurrentUsersUUIDReply._();
  CurrentUsersUUIDReply createEmptyInstance() => create();
  static $pb.PbList<CurrentUsersUUIDReply> createRepeated() => $pb.PbList<CurrentUsersUUIDReply>();
  @$core.pragma('dart2js:noInline')
  static CurrentUsersUUIDReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CurrentUsersUUIDReply>(create);
  static CurrentUsersUUIDReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get uuid => $_getList(0);
}

class StartSpeakingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StartSpeakingRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'helloworld'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..hasRequiredFields = false
  ;

  StartSpeakingRequest._() : super();
  factory StartSpeakingRequest({
    $core.String? uuid,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    return _result;
  }
  factory StartSpeakingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StartSpeakingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StartSpeakingRequest clone() => StartSpeakingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StartSpeakingRequest copyWith(void Function(StartSpeakingRequest) updates) => super.copyWith((message) => updates(message as StartSpeakingRequest)) as StartSpeakingRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StartSpeakingRequest create() => StartSpeakingRequest._();
  StartSpeakingRequest createEmptyInstance() => create();
  static $pb.PbList<StartSpeakingRequest> createRepeated() => $pb.PbList<StartSpeakingRequest>();
  @$core.pragma('dart2js:noInline')
  static StartSpeakingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StartSpeakingRequest>(create);
  static StartSpeakingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);
}

class StopSpeakingRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StopSpeakingRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'helloworld'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..hasRequiredFields = false
  ;

  StopSpeakingRequest._() : super();
  factory StopSpeakingRequest({
    $core.String? uuid,
  }) {
    final _result = create();
    if (uuid != null) {
      _result.uuid = uuid;
    }
    return _result;
  }
  factory StopSpeakingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StopSpeakingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StopSpeakingRequest clone() => StopSpeakingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StopSpeakingRequest copyWith(void Function(StopSpeakingRequest) updates) => super.copyWith((message) => updates(message as StopSpeakingRequest)) as StopSpeakingRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StopSpeakingRequest create() => StopSpeakingRequest._();
  StopSpeakingRequest createEmptyInstance() => create();
  static $pb.PbList<StopSpeakingRequest> createRepeated() => $pb.PbList<StopSpeakingRequest>();
  @$core.pragma('dart2js:noInline')
  static StopSpeakingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StopSpeakingRequest>(create);
  static StopSpeakingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uuid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uuid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUuid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUuid() => clearField(1);
}

class HelloRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HelloRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'helloworld'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..hasRequiredFields = false
  ;

  HelloRequest._() : super();
  factory HelloRequest({
    $core.String? name,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    return _result;
  }
  factory HelloRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HelloRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HelloRequest clone() => HelloRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HelloRequest copyWith(void Function(HelloRequest) updates) => super.copyWith((message) => updates(message as HelloRequest)) as HelloRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HelloRequest create() => HelloRequest._();
  HelloRequest createEmptyInstance() => create();
  static $pb.PbList<HelloRequest> createRepeated() => $pb.PbList<HelloRequest>();
  @$core.pragma('dart2js:noInline')
  static HelloRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HelloRequest>(create);
  static HelloRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);
}

class HelloReply extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'HelloReply', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'helloworld'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'message')
    ..hasRequiredFields = false
  ;

  HelloReply._() : super();
  factory HelloReply({
    $core.String? message,
  }) {
    final _result = create();
    if (message != null) {
      _result.message = message;
    }
    return _result;
  }
  factory HelloReply.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HelloReply.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HelloReply clone() => HelloReply()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HelloReply copyWith(void Function(HelloReply) updates) => super.copyWith((message) => updates(message as HelloReply)) as HelloReply; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HelloReply create() => HelloReply._();
  HelloReply createEmptyInstance() => create();
  static $pb.PbList<HelloReply> createRepeated() => $pb.PbList<HelloReply>();
  @$core.pragma('dart2js:noInline')
  static HelloReply getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HelloReply>(create);
  static HelloReply? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

