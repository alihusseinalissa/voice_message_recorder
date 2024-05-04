## Flutter voice message recorder


<div style="height:6px;"></div>

<div style="height:32px;"></div>

![](https://github.com/Moeed366/images/assets/101408316/d39904f4-9417-4c8b-919c-bc8c31c9079d)


## Demo

<div style="height:24px;"></div>

![](voice_message_recorder.gif)

<div style="height:12px;"></div>
<p style="font-size: 18px" >
voice message recorder is a flutter package you can record audio on single hold and also lock recorder to record
</p>
<div style="height:40px;"></div>

## Platform Support

| Android | iOS | MacOS | Web |
| :-----: | :-: | :---: | :-: |
|   ✔️    | ✔️  |  ✔️   | ✔️  |

<div style="height:16px;"></div>

## Installation

First add voice_message_recorder to your pubsbec.yaml file:

```yml
dependencies:
  voice_message_recorder: <latest-version>
```

<div style="height:12px;"></div>

Next, get package from pub dependencies:

```dart
flutter pub get
```

<div style="height:40px;"></div>

## How to use

All you need is pass your audio file src to VoiceMessageRecorder widget:

```dart
 VoiceMessageRecorder(
// maxRecordTimeInSecond: 5,
startRecording: () {
// function called when start recording
},
stopRecording: (_time) {
// function called when stop recording, return the recording time
},
sendRequestFunction: (soundFile, _time) {
//  print("the current path is ${soundFile.path}");
},
encode: AudioEncoderType.AAC,
),
```

## Todo


- [✔️] Handle exceptions.
- [✔️] Customization .
- [✔️] Dynamic width for voice widget.

<div style="height:32px;"></div>


<h2>
<a style="text-decoration: none; color: #0000ff" href="https://github.com/Moeed366">Moeed366</a>
</h2>

<div style="height:16px;"></div>
### Contributing


## License

Licensed under the MIT license. See [LICENSE](https://github.com/Moeed366/voice_message_recorder/blob/main/LICENSE "LICENSE").

