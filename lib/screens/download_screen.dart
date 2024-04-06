import 'dart:io';

import 'package:english_copy/screen_track.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class DownloadScreen extends StatefulWidget {
  static const routeName = "DownloadScreen";
  var list;
  DownloadScreen({super.key, required this.list});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  FlickManager? flickManager;

  Future getprefrence() async {
    flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.file(File(widget.list)));
    flickManager!.flickControlManager!.pause();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprefrence();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo/background.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              FlickVideoPlayer(
                preferredDeviceOrientation: [
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                  DeviceOrientation.portraitUp
                ],
                flickManager: flickManager!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
