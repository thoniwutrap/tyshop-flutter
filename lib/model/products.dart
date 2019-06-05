import 'package:meta/meta.dart';

class Products {

  final String name;
  final String desc;

  Products({
    @required this.name,
    @required this.desc,
  });

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'desc': desc,
      };

}