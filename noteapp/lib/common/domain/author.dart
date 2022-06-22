//
class Author {
  int id;
  String name;
  String logo =
      'https://ssyerv1.oss-cn-hangzhou.aliyuncs.com/picture/389e31d03d36465d8acd9939784df6f0.jpg!sswm';
  Author({this.id = 0, this.name = "无名之辈", String logo = ""}) {
    if (logo != "") {
      this.logo = logo;
    }
  }
}

Author mockAuthor = Author();
