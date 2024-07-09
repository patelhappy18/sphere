import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage(
      {Key? key,
      required this.userID,
      required this.userName,
      required this.callID})
      : super(key: key);
  final String callID;
  final String userID;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          271565237, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          "777238dbd0d6cd08c27a71d774ca7c54d7cfd2518d6db690cce826659de7023d ", // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: userID,
      userName: userName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
