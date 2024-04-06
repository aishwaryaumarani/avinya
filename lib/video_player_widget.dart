import 'package:english_copy/provider_pages/get_courses.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  String arguments;
  String destination;
  int lessionid;
  int courseid;
  GetCoursesProvider coursesProvider;
  VideoPlayerWidget(
      {Key? key,
      required this.arguments,
      required this.destination,
      required this.lessionid,
      required this.courseid,
      required this.coursesProvider})
      : super(key: key);
  static final GlobalKey<VideoPlayerWidgetState> cartKey = GlobalKey();

  @override
  State<VideoPlayerWidget> createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  FlickManager? flickManager;
  Future<void>? _initializeVideoPlayerFuture;
  bool show = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.network(widget.arguments));
    flickManager!.flickControlManager!.pause();
    print("hellos ${widget.arguments}");
    if (flickManager != null) {
      flickManager!.flickVideoManager!.addListener(listner);
    }
    // _controller = VideoPlayerController.network(widget.arguments);
    // _initializeVideoPlayerFuture = _controller!.initialize().then((value) {
    //     _controller!.setVolume(1);
    //     _controller!.pause();
    //     setState(() {});
    //   });
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (MediaQuery.of(context).orientation == Orientation.landscape) {
      //   print("changing orintation doing doing");
      //   flickManager!.flickControlManager!.enterFullscreen();
      // } else if (MediaQuery.of(context).orientation == Orientation.portrait) {
      //   flickManager!.flickControlManager!.exitFullscreen();
      // }
    });
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // print("hay hay ${widget.arguments}");
    // _controller!.dispose();
    // _controller = VideoPlayerController.network(widget.arguments);
    // print("chi chi  ${widget.arguments}");
    // _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
    //   _controller!.setVolume(1);
    //   _controller!.pause();
    //   setState(() {});
    // });
  }

  Future listner() async {
    if (flickManager != null &&
        widget.destination.compareTo("CourseVideo") == 0) {
      int left = ((flickManager!
                      .flickVideoManager!.videoPlayerValue!.position.inSeconds /
                  flickManager!.flickVideoManager!.videoPlayerValue!.duration
                      .inSeconds) *
              100)
          .truncate();
      if (left == 95) {
        var result = await widget.coursesProvider
            .uploadLessonCompleted(widget.courseid, widget.lessionid);
        print("progression");

        var completed = await widget.coursesProvider.getLessonCompleted();

        for (var element in (completed as Map)["data"]) {
          if (element["lesson"].length == element["lessonComplated"].length) {
            if (show) {
              var lesson = await widget.coursesProvider
                  .createCerti(widget.courseid, widget.lessionid);
              print(lesson);
              if(this.mounted){
                setState(() {
                show = false;
              });
              }
            }
            flickManager!.flickVideoManager!.removeListener(listner);
          }
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flickManager!.flickVideoManager!.removeListener(listner);
    flickManager!.flickControlManager!.pause();
    flickManager!.dispose();
      show = true;
  }

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(
      preferredDeviceOrientation: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitUp
      ],
      flickManager: flickManager!,
    );
    // return _controller!.value.isInitialized
    //                     ? Stack(
    //                         children: [
    //                           AspectRatio(
    //                             aspectRatio: _controller!.value.aspectRatio,
    //                             child: VideoPlayer(_controller!),
    //                           ),
    //                           Positioned.fill(
    //                             child: GestureDetector(
    //                               behavior: HitTestBehavior.opaque,
    //                               onTap: () => setState(() {
    //                                 _controller!.value.isPlaying
    //                                     ? _controller!.pause()
    //                                     : null;
    //                               }),
    //                               child: _controller!.value.isPlaying
    //                                   ? Container(
    //                                       // alignment: Alignment.center,
    //                                       // color: Colors.black26,
    //                                       // child: Icon(Icons.pause,color: Colors.white,size: 80,),
    //                                       )
    //                                   : Visibility(
    //                                       visible:
    //                                           _controller!.value.isPlaying
    //                                               ? false
    //                                               : true,
    //                                       child: Container(
    //                                         alignment: Alignment.center,
    //                                         color: Colors.black26,
    //                                         child: Row(
    //                                           mainAxisAlignment:
    //                                               MainAxisAlignment
    //                                                   .spaceEvenly,
    //                                           children: [
    //                                             IconButton(
    //                                               onPressed: () {
    //                                                 _controller!.seekTo(Duration(
    //                                                     seconds: _controller!
    //                                                             .value
    //                                                             .position
    //                                                             .inSeconds -
    //                                                         10));
    //                                               },
    //                                               icon: Icon(
    //                                                 Icons.replay_10,
    //                                                 color: Colors.white,
    //                                                 size: 50,
    //                                               ),
    //                                             ),
    //                                             IconButton(
    //                                               onPressed: () {
    //                                                 setState(() {
    //                                                   _controller!.play();
    //                                                 });
    //                                               },
    //                                               icon: Icon(
    //                                                 Icons.play_arrow,
    //                                                 color: Colors.white,
    //                                                 size: 50,
    //                                               ),
    //                                             ),
    //                                             IconButton(
    //                                               onPressed: () {
    //                                                 _controller!.seekTo(Duration(
    //                                                     seconds: _controller!
    //                                                             .value
    //                                                             .position
    //                                                             .inSeconds +
    //                                                         10));
    //                                               },
    //                                               icon: Icon(
    //                                                 Icons.forward_10,
    //                                                 color: Colors.white,
    //                                                 size: 50,
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                     ),
    //                             ),
    //                           ),
    //                           Positioned(
    //                             left: 0,
    //                             right: 0,
    //                             bottom: 0,
    //                             child: VideoProgressIndicator(
    //                               _controller!,
    //                               allowScrubbing: true,
    //                             ),
    //                           ),
    //                         ],
    //                       )
    //                     : Center(child: CircularProgressIndicator());
  }
}
