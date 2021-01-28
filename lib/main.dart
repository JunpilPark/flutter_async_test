import 'dart:async';
import 'dart:io';

void main() async {
  print("메인이 실행됩니다.");
  Repository repo = Repository();
  print("프로그래스 진행 ");
  List<TimeLineItem> tinelines = await repo.getTimelineList();
  print("타임라인 위젯이 그려집니다 시작 ");

  for(TimeLineItem item in tinelines) {
    print("타임라인 위젯이 그려집니다. $item");
  }
  print("메인이 종료됩니다.");
}

class Repository {
  Future<List<TimeLineItem>> getTimelineList() async {
    List<String> ids = ["1", "2", "3", "4", "5"];
    List<TimeLineItem> timelines = List();
    for (String id in ids) {
      List<String> data = await _getDataForTimeLineItem(id);
      timelines.add(TimeLineItem(data[2], date: data[0], imageUrl: data[1]));
    }
    return Future.sync(() => timelines);
    /*for(TimeLineItem item in timelines) {
      print("타임라인 : $item");
    }*/

  }

  Future<List<String>> _getDataForTimeLineItem(String id) async {
    Future<String> date = getDate(id);
    Future<String> image = getImageUrl(id);
    Future<String> contents = getContents(id);
    List<String> values = await Future.wait([date, image, contents]);
    return values;
  }

  Future<String> getDate(String id)  {
    return Future(
      () {
        print("${DateTime.now()} getDate start : $id");
       for(int i = 0; i < 1000000000 ; i ++) {
         ;
       }
        print("${DateTime.now()} getDate end : $id");
        return "2020-01-28_$id";
      });
  }

  Future<String> getImageUrl(String id) {
    return Future(
            () {
              print("${DateTime.now()} getImageUrl : $id");
              for(int i = 0; i < 10000000 ; i ++) {
                ;
              }
              print("${DateTime.now()} getImageUrl : $id");
      return "https://imageURL.$id";
    });
  }

  Future<String> getContents(String id)  {
    return Future(() {
              print("${DateTime.now()} getContents : $id");
              for(int i = 0; i < 1000 ; i ++) {
                ;
              }
              print("${DateTime.now()} getContents : $id");
              return "$id";
        });
  }
}


class TimeLineItem {

  final String contents;
  final String date;
  final String imageUrl;

  TimeLineItem(this.contents, {this.date, this.imageUrl});

  @override
  String toString() {
    return 'TimeLineItem{contents: $contents, date: $date, imageUrl: $imageUrl}';
  }
}