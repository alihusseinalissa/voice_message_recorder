import 'package:flutter_test/flutter_test.dart';
import 'package:voice_message_recorder/voice_message_recorder.dart';
import 'package:voice_message_recorder/voice_message_recorder_platform_interface.dart';
import 'package:voice_message_recorder/voice_message_recorder_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockVoiceMessageRecorderPlatform
    with MockPlatformInterfaceMixin
    implements VoiceMessageRecorderPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final VoiceMessageRecorderPlatform initialPlatform = VoiceMessageRecorderPlatform.instance;

  test('$MethodChannelVoiceMessageRecorder is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelVoiceMessageRecorder>());
  });

  test('getPlatformVersion', () async {
    VoiceMessageRecorder voiceMessageRecorderPlugin = VoiceMessageRecorder();
    MockVoiceMessageRecorderPlatform fakePlatform = MockVoiceMessageRecorderPlatform();
    VoiceMessageRecorderPlatform.instance = fakePlatform;

    expect(await voiceMessageRecorderPlugin.getPlatformVersion(), '42');
  });
}
