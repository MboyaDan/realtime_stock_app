class NewsModel{
  final String title;
  final String source;
  final String timeAgo;
  final String imageUrl;
  final String summary;
  final String url;

  NewsModel({
    required this.title,
    required this.source ,
    required this.timeAgo,
    required this.imageUrl,
    required this.summary,
  required this.url});

  //covert Firestore Document to 'newsmodel'
factory NewsModel.fromMap(Map<String, dynamic> map){
  return NewsModel(
      title: map['title']?? 'No Title',
      source: map ['source']?? 'Unknon Source',
      timeAgo: map['timeAgo']??'',
      imageUrl: map ['imageUrl']?? '',
      summary: map['summary'] ?? 'No summary available',
      url: map['url']
  );

}

// Convert `NewsModel` to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'source': source,
      'timeAgo': timeAgo,
      'imageUrl': imageUrl,
      'summary': summary,
      'url': url,
    };
  }


}