#include "include/voice_message_recorder/voice_message_recorder_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "voice_message_recorder_plugin.h"

void VoiceMessageRecorderPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  voice_message_recorder::VoiceMessageRecorderPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
