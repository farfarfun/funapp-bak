const String defaultLogo =
    'https://ssyerv1.oss-cn-hangzhou.aliyuncs.com/picture/389e31d03d36465d8acd9939784df6f0.jpg!sswm';

class Author {
  int id;
  String name;
  String desc;
  String logo = defaultLogo;

  Author({this.id = 0, this.name = "无名之辈", this.desc = '', String logo = ""}) {
    if (logo != "") {
      this.logo = logo;
    }
  }
  static Author fromJson(Map<String, dynamic> json) {
    return Author(
        id: json.containsKey('id') ? json['id'] : 0,
        desc: json.containsKey('desc') ? json['desc'] : '',
        name: json.containsKey('name') ? json['name'] : '朱二旦的枯燥生活',
        logo: json.containsKey('logo') ? json['logo'] : defaultLogo);
  }
}

Author mockAuthor = Author();
