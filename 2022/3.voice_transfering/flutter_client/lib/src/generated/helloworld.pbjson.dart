///
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use voiceRequestDescriptor instead')
const VoiceRequest$json = const {
  '1': 'VoiceRequest',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'voice', '3': 3, '4': 1, '5': 12, '10': 'voice'},
  ],
};

/// Descriptor for `VoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voiceRequestDescriptor = $convert.base64Decode('CgxWb2ljZVJlcXVlc3QSEgoEdXVpZBgBIAEoCVIEdXVpZBIcCgl0aW1lc3RhbXAYAiABKANSCXRpbWVzdGFtcBIUCgV2b2ljZRgDIAEoDFIFdm9pY2U=');
@$core.Deprecated('Use voiceReplyDescriptor instead')
const VoiceReply$json = const {
  '1': 'VoiceReply',
  '2': const [
    const {'1': 'uuid', '3': 1, '4': 1, '5': 9, '10': 'uuid'},
    const {'1': 'timestamp', '3': 2, '4': 1, '5': 3, '10': 'timestamp'},
    const {'1': 'voice', '3': 3, '4': 1, '5': 12, '10': 'voice'},
  ],
};

/// Descriptor for `VoiceReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voiceReplyDescriptor = $convert.base64Decode('CgpWb2ljZVJlcGx5EhIKBHV1aWQYASABKAlSBHV1aWQSHAoJdGltZXN0YW1wGAIgASgDUgl0aW1lc3RhbXASFAoFdm9pY2UYAyABKAxSBXZvaWNl');
@$core.Deprecated('Use helloRequestDescriptor instead')
const HelloRequest$json = const {
  '1': 'HelloRequest',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
  ],
};

/// Descriptor for `HelloRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloRequestDescriptor = $convert.base64Decode('CgxIZWxsb1JlcXVlc3QSEgoEbmFtZRgBIAEoCVIEbmFtZQ==');
@$core.Deprecated('Use helloReplyDescriptor instead')
const HelloReply$json = const {
  '1': 'HelloReply',
  '2': const [
    const {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `HelloReply`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloReplyDescriptor = $convert.base64Decode('CgpIZWxsb1JlcGx5EhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2U=');
