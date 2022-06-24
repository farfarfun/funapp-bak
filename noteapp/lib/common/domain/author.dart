const String defaultLogo =
    'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif';

class Author {
  final int id;
  final String name;
  final String desc;
  final String logo;

  const Author(
      {this.id = 0,
      this.name = "无名之辈",
      this.desc = '',
      this.logo = defaultLogo});
  static Author fromJson(Map<String, dynamic> json) {
    return Author(
        id: json.containsKey('id') ? json['id'] : 0,
        desc: json.containsKey('desc') ? json['desc'] : '',
        name: json.containsKey('name') ? json['name'] : '朱二旦的枯燥生活',
        logo: json.containsKey('logo') ? json['logo'] : defaultLogo);
  }
}

const Author mockAuthor = const Author(id: 0, name: '无名氏', desc: '无名氏无户籍');
