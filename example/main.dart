import 'package:link_preview/link_preview.dart';

var links = [
  "https://www.circuitlab.com/circuit/pz43c8wwj2de/potentiometer-inquiry/",
  "https://coub.com/view/2gkzwz",
  "https://www.iheart.com/podcast/1119-red-table-talk-63922369/episode/motherhood-68561795/?embed=true",
  "https://youtu.be/xaFPt4qwZOI"
];

void main(List<String> arguments) async {
  // Normal sample
  fetchPageInfoDirectly();

  // Warm up example
  warmUpAndFetchPageInfo();
}

void warmUpAndFetchPageInfo() async {
  // Apps can warm up link_preview on app launch
  // Warm up API will cache data needed to extract page info
  // Warm up is an optional step. Warming up will help reduce 1-2 seconds
  LinkPreview.warmUp();

  await Future.delayed(Duration(milliseconds: 1000), () {
    // Waiting for scheme to load
  });

  for (String url in links) {
    var data = await LinkPreview.getPageInfo(url);
    print(data["thumbnail_url"]);
    print(data["provider_url"]);
  }
}

void fetchPageInfoDirectly() async {
  for (String url in links) {
    var data = await LinkPreview.getPageInfo(url);
    print(data["provider_name"]);
  }
}
