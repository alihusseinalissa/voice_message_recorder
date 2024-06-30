import 'package:flutter/material.dart';
import 'package:voice_message_recorder/mySize.dart';
import 'package:voice_message_recorder/phone_textfield/phone_number_field.dart';
import 'package:voice_message_recorder/voice_message_player/src/voice_controller.dart';
import 'package:voice_message_recorder/voice_message_player/src/voice_message_view.dart';
import 'package:voice_message_recorder/voice_message_recorder/audio_encoder_type.dart';
import 'package:voice_message_recorder/voice_message_recorder/screen/voice_message_recorder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MM().init(context);
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text('LoginScreen')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SingleChatScreen()));
            },
            child: Text('SingleChatScreen')),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => player()));
            },
            child: Text('player')),
      ],
    );
  }
}

class player extends StatelessWidget {
  player({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              VoiceMessagePlayer(
                controller: VoiceController(
                  audioSrc:
                      'https://dl.solahangs.com/Music/1403/02/H/128/Hiphopologist%20-%20Shakkak%20%28128%29.mp3',
                  maxDuration: const Duration(seconds: 10),
                  isFile: false,
                  onComplete: () {
                    /// do something on complete
                  },
                  onPause: () {
                    /// do something on pause
                  },
                  onPlaying: () {
                    /// do something on playing
                  },
                  onError: (err) {
                    /// do somethin on error
                  },
                ),
                innerPadding: 12,
                cornerRadius: 20,
              ),
              VoiceMessagePlayer(
                controller: VoiceController(
                  audioSrc:
                      'https://cdn.pixabay.com/download/audio/2022/11/16/audio_a2b0a45199.mp3?filename=6-islamic-background-sounds-alfa-relaxing-music-126060.mp3',
                  maxDuration: const Duration(seconds: 10),
                  isFile: false,
                  onComplete: () {
                    /// do something on complete
                  },
                  onPause: () {
                    /// do something on pause
                  },
                  onPlaying: () {
                    /// do something on playing
                  },
                  onError: (err) {
                    /// do somethin on error
                  },
                ),
                innerPadding: 12,
                cornerRadius: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String? data;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              InternationalPhoneNumberTextField(
                height: 60,
                controller: controller,
                inputFormatters: const [],
                formatter: MaskedInputFormatter('### ### ## ##'),
                initCountry: CountryCodeModel(
                    name: "United States", dial_code: "+1", code: "US"),
                betweenPadding: 23,
                onInputChanged: (phone) {
                  print(phone.code);
                  print(phone.dial_code);
                  print(phone.number);
                  print(phone.rawFullNumber);
                  print(phone.rawNumber);
                  print(phone.rawDialCode);
                },
                dialogConfig: DialogConfig(
                  backgroundColor: const Color(0xFF444448),
                  searchBoxBackgroundColor: const Color(0xFF56565a),
                  searchBoxIconColor: const Color(0xFFFAFAFA),
                  countryItemHeight: 55,
                  flatFlag: true,
                  topBarColor: const Color(0xFF1B1C24),
                  selectedItemColor: const Color(0xFF56565a),
                  selectedIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      "assets/check.png",
                      width: 20,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  textStyle: TextStyle(
                      color: const Color(0xFFFAFAFA).withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  searchBoxTextStyle: TextStyle(
                      color: const Color(0xFFFAFAFA).withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  titleStyle: const TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  searchBoxHintStyle: TextStyle(
                      color: const Color(0xFFFAFAFA).withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                countryConfig: CountryConfig(
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: const Color(0xFF3f4046)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    flatFlag: true,
                    noFlag: false,
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                validator: (number) {
                  if (number.number.isEmpty) {
                    return "The phone number cannot be left emptyssss";
                  }
                  return null;
                },
                phoneConfig: PhoneConfig(
                  focusedColor: const Color(0xFF6D59BD),
                  enabledColor: const Color(0xFF6D59BD),
                  errorColor: const Color(0xFFFF5494),
                  labelStyle: null,
                  labelText: null,
                  floatingLabelStyle: null,
                  focusNode: null,
                  radius: 8,
                  hintText: "Phone Number",
                  borderWidth: 2,
                  backgroundColor: Colors.transparent,
                  decoration: null,
                  popUpErrorText: true,
                  autoFocus: false,
                  showCursor: false,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  errorTextMaxLength: 2,
                  errorPadding: const EdgeInsets.only(top: 14),
                  errorStyle: const TextStyle(
                      color: Color(0xFFFF5494), fontSize: 12, height: 1),
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _isLoading = false;

  void _handleData(String data) {
    print("sdfsfsfsfsfsfsfsfsf#$data");
    setState(() {
      _isLoading = true; // Show progress indicator
    });

    // Simulate data processing
    Future.delayed(const Duration(seconds: 2), () {
      // After processing, hide progress indicator
      setState(() {
        _isLoading = false;
      });
      // Do something with the data
      print("Received data from child: $data");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Widget'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator() // Show progress indicator
            : ChildWidget(onDataReceived: _handleData),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  final Function(String) onDataReceived;

  const ChildWidget({super.key, required this.onDataReceived});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Simulate getting data
        String data = "Some data";
        // Pass data back to parent
        onDataReceived(data);
      },
      child: const Text('Send Data to Parent'),
    );
  }
}

class SingleChatScreen extends StatelessWidget {
  const SingleChatScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          VoiceMessageRecorder(
            functionStartRecording: () {
              // function called when start recording
            },
            functionStopRecording: (time) {
              // function called when stop recording, return the recording time
            },
            functionSendVoice: (soundFile, time) {
              //  print("the current path is ${soundFile.path}");
            },
            encode: AudioEncoderType.AAC,
            functionRecorderStatus: (bool) {},
            functionSendTextMessage: (String text) {},
            functionDataCameraReceived: (String) {
              print(
                  "-VIDELCGVVDHCFCHGCDCHCDHCDHCDHCD    -$String-----------------------------------------------CAMERAA");
            },
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: MM.x20 / 2),
      ],
    );
  }
}
