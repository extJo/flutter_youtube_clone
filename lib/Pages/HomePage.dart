import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:youtube_flutter_clone/Assets/String.dart';
import 'package:youtube_flutter_clone/Assets/Color.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import '../Model/VideoData.dart';

/// HomePage Widget
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key : key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

/// HomePage Widget State
class _HomePageState extends State<HomePage> {
  List<VideoData> playDataList = [];

  @override
  void initState() {
    super.initState();

    loadData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _showLoadingIndicator();
    });
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: playDataList.length,
    itemBuilder: (BuildContext context, int index) => myTubeListItem(index),
  );

  /// ListView Item Widget Builder
  Widget myTubeListItem(int index) {
    return InkWell(
      onLongPress: _modalBottomSheet,
      child: Container(
//        margin: EdgeInsets.all(10.0),
        decoration: new BoxDecoration(

//          border: new Border.all(color: BorderColor),
//          borderRadius: BorderRadius.all(Radius.elliptical(5.0, 5.0)),
//          color: Colors.white,
//          boxShadow: <BoxShadow>[
//            BoxShadow(
//              color: Colors.grey,
//              blurRadius: 5.0,
//            )
//          ],
          border: new Border(bottom: new BorderSide(color: BorderColor)),
        ),
        child: new Padding(
          padding: const EdgeInsets.all(15.0),
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              _myTubeVideoThumbnail(index),
              _myTubeVideoContent(index),
            ],
          ),
        ),
      ),
    );
  }

  /// Video Thumbnail builder at ListView Item Widget
  _myTubeVideoThumbnail(int index) => AspectRatio(
      aspectRatio: 1.8,
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: playDataList[index].getThumbnailUrl,
        fit: BoxFit.cover,
      )
  );

  /// Video Content View builder at ListView Item Widget
  _myTubeVideoContent(int index) => Container(
    alignment: Alignment.topCenter,
    margin: EdgeInsets.only(top: 10.0),
    child: Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: BorderColor,
            image: DecorationImage(
              image: NetworkImage(playDataList[index].getChannelData.getThumbnailUrl),
              fit: BoxFit.contain,
            )
          ),
          width: 32.0,
          height: 32.0,
        ),
        Flexible(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  playDataList[index].getTitle,
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                      color: TextColor
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${playDataList[index].getChannelData.getName} · ${_videoViewTextTruncate(playDataList[index].getViewCount)} · ${_videoPublishedDate(playDataList[index].getPublishedDate)}",
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: TextColor,),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
          flex: 1,
        ),
        InkWell(
            child: Container(child: Icon(Icons.more_vert, size: 20.0, color: BorderColor),),
            onTap: _modalBottomSheet,
            borderRadius: BorderRadius.circular(20.0)
        )
      ],
    ),
  );

  _videoViewTextTruncate(String viewCount) {
    double doubleViewCount = double.parse(viewCount);
    String returnViewCount = "";

    if (doubleViewCount / 100000000 >= 1) {
      returnViewCount = "조회수 ${(doubleViewCount / 100000000).round()}억회";
    } else if (doubleViewCount / 10000 >= 1) {
      returnViewCount = "조회수 ${(doubleViewCount / 10000).round()}만회";
    } else if (doubleViewCount / 1000 >= 1) {
      returnViewCount = "조회수 ${(doubleViewCount / 1000).round()}천회";
    }

    return returnViewCount;
  }

  _videoPublishedDate(String date) {
    var nowDate = new DateTime.now();
    var publishedDate = DateTime.parse(date);
    String returnDate = "";

    Duration difference = nowDate.difference(publishedDate);

    if (difference.inMinutes < 1) {
      returnDate = "${difference.inSeconds}초 전";
    } else if (difference.inHours < 1) {
      returnDate = "${difference.inMinutes}분 전";
    } else if (difference.inDays < 1) {
      returnDate = "${difference.inHours}시간 전";
    } else {
      returnDate = "${difference.inDays}일 전";
    }

    return returnDate;
  }

  /// method for show BottomSheet
  _modalBottomSheet() => showModalBottomSheet(
    context: context,
    builder: (builder) => Container(
      color: AppBackgroundColor,
      child: new Column(
        children: <Widget>[
          _bottomSheetListTile(Icons.not_interested, "관심 없음", () => debugPrint("+++")),
          _bottomSheetListTile(Icons.access_time, "나중에 볼 동영상에 추가", () => debugPrint("+++")),
          _bottomSheetListTile(Icons.playlist_add, "재생목록에 추가", () => debugPrint("+++")),
          _bottomSheetListTile(Icons.share, "공유", () => debugPrint("+++")),
          _bottomSheetListTile(Icons.flag, "신고", () => debugPrint("+++")),
          Container(
            decoration: new BoxDecoration(
                border: new Border(top: new BorderSide(color: BorderColor))
            ),
            child: _bottomSheetListTile(Icons.close, "취소", () => Navigator.pop(context)),
          )
        ],

      ),
    )
  );

  /// list tile builder for BottomSheet
  _bottomSheetListTile(IconData icon, String text, Function onTap) =>
      ListTile(
          leading: Icon(icon, color: TextColor),
          title: Text(text, style: TextStyle(color: TextColor),),
          onTap: onTap
      );

  /// method for show loading indicator using [showDialog]
  _showLoadingIndicator() => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => new Container(
        child: new Center(
          child: new CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(AppBarColor),
          ),
        ),
      ),
  );

  /// Network for get Youtube Video List And Youtube Channel Thumbnail
  loadData() async {
    List<VideoData> videoDataList = new List<VideoData>();
    String dataURL = "https://www.googleapis.com/youtube/v3/videos?chart=mostpopular&regionCode=KR"
        "&maxResults=20&key=$youtubeApiKey&part=snippet,contentDetails,statistics,status";

    http.Response response = await http.get(dataURL);
    dynamic resBody = json.decode(response.body);
    List videosResData = resBody["items"];

    videosResData.forEach((item) => videoDataList.add(new VideoData(item)));

    for (var videoData in videoDataList) {
      String channelDataURL = "https://www.googleapis.com/youtube/v3/channels?key=$youtubeApiKey&part=snippet&id=${videoData.getOwnerChannelId}";

      http.Response channelResponse = await http.get(channelDataURL);
      dynamic channelResBody = json.decode(channelResponse.body);

      videoData.channelDataFromJson = channelResBody["items"][0];
    }

    setState(() {
      playDataList = videoDataList;
    });

    Navigator.pop(context);
  }
}