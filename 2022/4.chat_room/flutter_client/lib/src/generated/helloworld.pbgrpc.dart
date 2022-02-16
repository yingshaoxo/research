///
//  Generated code. Do not modify.
//  source: helloworld.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'helloworld.pb.dart' as $0;
export 'helloworld.pb.dart';

class GreeterClient extends $grpc.Client {
  static final _$sayHello = $grpc.ClientMethod<$0.HelloRequest, $0.HelloReply>(
      '/helloworld.Greeter/SayHello',
      ($0.HelloRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HelloReply.fromBuffer(value));
  static final _$sendVoice = $grpc.ClientMethod<$0.VoiceRequest, $0.Empty>(
      '/helloworld.Greeter/SendVoice',
      ($0.VoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$getVoice = $grpc.ClientMethod<$0.Empty, $0.VoiceReply>(
      '/helloworld.Greeter/GetVoice',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VoiceReply.fromBuffer(value));
  static final _$getCurrentUsersUUID =
      $grpc.ClientMethod<$0.Empty, $0.CurrentUsersUUIDReply>(
          '/helloworld.Greeter/GetCurrentUsersUUID',
          ($0.Empty value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.CurrentUsersUUIDReply.fromBuffer(value));
  static final _$startSpeaking =
      $grpc.ClientMethod<$0.StartSpeakingRequest, $0.Empty>(
          '/helloworld.Greeter/StartSpeaking',
          ($0.StartSpeakingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$stopSpeaking =
      $grpc.ClientMethod<$0.StopSpeakingRequest, $0.Empty>(
          '/helloworld.Greeter/StopSpeaking',
          ($0.StopSpeakingRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  GreeterClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.HelloReply> sayHello($0.HelloRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> sendVoice(
      $async.Stream<$0.VoiceRequest> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendVoice, request, options: options).single;
  }

  $grpc.ResponseStream<$0.VoiceReply> getVoice($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getVoice, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.CurrentUsersUUIDReply> getCurrentUsersUUID(
      $0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getCurrentUsersUUID, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> startSpeaking($0.StartSpeakingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$startSpeaking, request, options: options);
  }

  $grpc.ResponseFuture<$0.Empty> stopSpeaking($0.StopSpeakingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stopSpeaking, request, options: options);
  }
}

abstract class GreeterServiceBase extends $grpc.Service {
  $core.String get $name => 'helloworld.Greeter';

  GreeterServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloReply>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VoiceRequest, $0.Empty>(
        'SendVoice',
        sendVoice,
        true,
        false,
        ($core.List<$core.int> value) => $0.VoiceRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.VoiceReply>(
        'GetVoice',
        getVoice_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.VoiceReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.CurrentUsersUUIDReply>(
        'GetCurrentUsersUUID',
        getCurrentUsersUUID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.CurrentUsersUUIDReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StartSpeakingRequest, $0.Empty>(
        'StartSpeaking',
        startSpeaking_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.StartSpeakingRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.StopSpeakingRequest, $0.Empty>(
        'StopSpeaking',
        stopSpeaking_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.StopSpeakingRequest.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloReply> sayHello_Pre(
      $grpc.ServiceCall call, $async.Future<$0.HelloRequest> request) async {
    return sayHello(call, await request);
  }

  $async.Stream<$0.VoiceReply> getVoice_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* getVoice(call, await request);
  }

  $async.Future<$0.CurrentUsersUUIDReply> getCurrentUsersUUID_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getCurrentUsersUUID(call, await request);
  }

  $async.Future<$0.Empty> startSpeaking_Pre($grpc.ServiceCall call,
      $async.Future<$0.StartSpeakingRequest> request) async {
    return startSpeaking(call, await request);
  }

  $async.Future<$0.Empty> stopSpeaking_Pre($grpc.ServiceCall call,
      $async.Future<$0.StopSpeakingRequest> request) async {
    return stopSpeaking(call, await request);
  }

  $async.Future<$0.HelloReply> sayHello(
      $grpc.ServiceCall call, $0.HelloRequest request);
  $async.Future<$0.Empty> sendVoice(
      $grpc.ServiceCall call, $async.Stream<$0.VoiceRequest> request);
  $async.Stream<$0.VoiceReply> getVoice(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.CurrentUsersUUIDReply> getCurrentUsersUUID(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Future<$0.Empty> startSpeaking(
      $grpc.ServiceCall call, $0.StartSpeakingRequest request);
  $async.Future<$0.Empty> stopSpeaking(
      $grpc.ServiceCall call, $0.StopSpeakingRequest request);
}
