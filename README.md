# link_preview

Dart library to get information needed to load previews for links

## Getting Started

### Adding dependency
Add "link_preview: {{latest-version}}" under dependencies in your pubspec.yaml.
Perform "Pub get" after adding dependency.

### Warm up link preview

Apps can warm up link_preview on app launch. Warm up API will cache data needed to extract page info.
Warm up is an optional step. Warming up will help reduce 1-2 seconds on first page load.

```
    LinkPreview.warmUp();
```

### Loading Page Info to show preview

```
    var data = await LinkPreview.getPageInfo(url);
    print(data["provider_name"]);
    print(data["thumbnail_url"]);
    print(data["provider_url"]);
```
data will be in same specification as OEmbed provider.
Ref. https://oembed.com/#section2
