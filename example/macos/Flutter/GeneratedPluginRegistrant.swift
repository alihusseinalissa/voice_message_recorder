//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import audioplayers_darwin
import emoji_picker_flutter
import just_audio
import path_provider_foundation
import record_macos
import shared_preferences_foundation
import video_player_avfoundation
import voice_message_recorder

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  AudioplayersDarwinPlugin.register(with: registry.registrar(forPlugin: "AudioplayersDarwinPlugin"))
  EmojiPickerFlutterPlugin.register(with: registry.registrar(forPlugin: "EmojiPickerFlutterPlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  RecordMacosPlugin.register(with: registry.registrar(forPlugin: "RecordMacosPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  FVPVideoPlayerPlugin.register(with: registry.registrar(forPlugin: "FVPVideoPlayerPlugin"))
  VoiceMessageRecorderPlugin.register(with: registry.registrar(forPlugin: "VoiceMessageRecorderPlugin"))
}
