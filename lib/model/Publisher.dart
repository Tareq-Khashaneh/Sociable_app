import 'package:task_1/model/media.dart';

class Publisher{
  final String name;
  String? imgProfile;
  late List<Media> mediasObj;
  final List<dynamic> medias;
  Publisher({required this.name,required this.medias})
  {
    mediasObj = [];

  }
  factory Publisher.fromJson(Map<String,dynamic> data)
  => Publisher(name: data['name'],medias:  data['media']);
}