class GiphyPage {
  final List<GiphyImageInfo> data;
  final GiphyPagination pagination;
  final GiphyMeta meta;

  GiphyPage.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List).map((j) => GiphyImageInfo.fromJson(j)).toList(),
        pagination = GiphyPagination.fromJson(json['pagination']),
        meta = GiphyMeta.fromJson(json['meta']);
}

class GiphyPagination {
  final int offset;
  final int count;
  final int totalCount;

  GiphyPagination.fromJson(Map<String, dynamic> json)
      : offset = json['offset'],
        count = json['count'],
        totalCount = json['total_count'];
}

class GiphyMeta {
  final int status;

  GiphyMeta.fromJson(Map<String, dynamic> json)
      : status = json['status'];
}

class GiphyImageInfo {
  final String title;
  final GiphyImages images;

  GiphyImageInfo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        images = GiphyImages.fromJson(json['images']);
}

class GiphyImages {
  final GiphyImage downsized;
  final GiphyImage w480still;

  GiphyImages.fromJson(Map<String, dynamic> json)
      : downsized = GiphyImage.fromJson(json['downsized']),
        w480still = GiphyImage.fromJson(json['480w_still']);
}

class GiphyImage {
  final int width;
  final int height;
  final String url;

  GiphyImage.fromJson(Map<String, dynamic> json)
      : width = int.parse(json['width']),
        height = int.parse(json['height']),
        url = json['url'];
}