
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  String appID = "23aebc5881804e7985ca53bc04ed415a";
  String certiID = "f47a6076cef6434abe9d9b3224ab15ef";
  String channelName = "gritstonevideocalling";
  AgoraClient? _client;

  Future<void> initAgora() async {
    
    _client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
            appId: appID, channelName: channelName, tempToken: "007eJxTYBA6pmh144H3BN7zO6afmbsq+nqi3atGzmuBBUe++pU9CwlQYDAyTkxNSja1sDC0MDBJNbe0ME1ONDVOSgZyUkwMTRM/Ltqc2hDIyLB7+wtmRgYIBPFFGdKLMkuKS/LzUssyU1LzkxNzcjLz0hkYAHFgKXo="));
    await _client!.initialize();
  }

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            'Video Call',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                client: _client!,
                layoutType: Layout.floating,
                showNumberOfUsers: true,
              ),
              AgoraVideoButtons(
                client: _client!,
                enabledButtons: const [
                  BuiltInButtons.switchCamera,
                  BuiltInButtons.toggleCamera,
                  BuiltInButtons.callEnd,
                  BuiltInButtons.toggleMic
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
