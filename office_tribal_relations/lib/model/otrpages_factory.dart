class OtrPages {
  String category;
  String categoryimage;
  List<Data> data;

  OtrPages({this.category, this.categoryimage, this.data});

  factory OtrPages.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['data'] as List;
    print(list.runtimeType);
    List<Data> dataList = list.map((i) => Data.fromJson(i)).toList();
    
    return OtrPages(
      category: parsedJson['category'],
      categoryimage: parsedJson['categoryimage'],
      data: dataList
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String title;
  String subtitle;
  String highlight;
  String mainimage;
  String landpagecontent;
  String weblink;
  String thiscategory;
  List<Sections> sections;

  Data(
      {this.title,
      this.subtitle,
      this.highlight,
      this.mainimage,
      this.landpagecontent,
      this.weblink,
      this.thiscategory,
      this.sections});

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['sections'] as List;
    print(list.runtimeType);
    List<Sections> sectionList = list.map((i) => Sections.fromJson(i)).toList();

    return Data(
        title: parsedJson['title'],
        subtitle: parsedJson['subtitle'],
        highlight: parsedJson['highlight'],
        mainimage: parsedJson['mainimage'],
        landpagecontent: parsedJson['landingpagecontent'],
        weblink: parsedJson['weblink'],
        thiscategory: parsedJson['thiscategory'],
        sections: sectionList);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['highlight'] = this.highlight;
    data['mainimage'] = this.mainimage;
    data['landingpagecontent'] = this.landpagecontent;
    data['weblink'] = this.weblink;
    data['thiscategory'] = this.thiscategory;
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  String content;
  String image;

  Sections({this.content, this.image});

  factory Sections.fromJson(Map<String, dynamic> parsedJson) {
    return Sections(content: parsedJson['content'], image: parsedJson['image']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['image'] = this.image;
    return data;
  }
}
