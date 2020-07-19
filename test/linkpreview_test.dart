import 'package:flutter_test/flutter_test.dart';
import 'package:link_preview/link_preview.dart';

var links = [
  "https://www.circuitlab.com/circuit/pz43c8wwj2de/potentiometer-inquiry/",
  "https://coub.com/view/2gkzwz",
  "https://www.facebook.com/100034183263437/videos/302917017524405/",
  "https://www.iheart.com/podcast/1119-red-table-talk-63922369/episode/motherhood-68561795/?embed=true",
  "https://youtu.be/xaFPt4qwZOI"
];

void loadData(String url) async {
  DateTime startTime = DateTime.now();
  var data = await LinkPreview.getPreviewInfo(url);
//  print(data);
  print(
      "${DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch} ms to load $url");
}

void main() {
  test('Test: Warm up API', () async {
    DateTime startTime = DateTime.now();
    LinkPreview.warmUp();
    print(
        "Warm up initiated in ${DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch}");

    await Future.delayed(Duration(milliseconds: 1000), () {
      // Waiting for scheme to load
    });

    startTime = DateTime.now();
    var data = await LinkPreview.getPreviewInfo(links[0]);
    print(
        "${DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch} ms to load ${links[0]}");

    startTime = DateTime.now();
    data = await LinkPreview.getPreviewInfo(links[1]);
    print(
        "${DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch} ms to load ${links[1]}");

    startTime = DateTime.now();
    data = await LinkPreview.getPreviewInfo(links[2]);
    print(
        "${DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch} ms to load ${links[2]}");

    startTime = DateTime.now();
    data = await LinkPreview.getPreviewInfo(links[3]);
    print(
        "${DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch} ms to load ${links[3]}");

    startTime = DateTime.now();
    data = await LinkPreview.getPreviewInfo(links[4]);
    print(
        "${DateTime.now().millisecondsSinceEpoch - startTime.millisecondsSinceEpoch} ms to load ${links[4]}");
  });

  test('Test: Warm up API', () async {
    print("Test: Serial API calls without warm up");
    loadData(links[0]);
    loadData(links[1]);
    loadData(links[2]);
    loadData(links[3]);
    loadData(links[4]);

    await Future.delayed(Duration(milliseconds: 5000), () {
      // Waiting for scheme to load
    });
  });
}
