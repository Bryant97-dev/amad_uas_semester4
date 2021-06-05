part of 'models.dart';



class Pins extends Equatable{
  final String pinId;
  final String pinName;
  final String pinCourse;
  final String pinDeadline;
  final String pinDesc;
  final String pinImage;
  final String pinFile;
  final String addBy;
  final String createdAt;
  final String updateAt;
Pins(
      this.pinId,
      this.pinName,
      this.pinCourse,
      this.pinDeadline,
      this.pinDesc,
      this.pinImage,
      this.pinFile,
      this.addBy,
      this.createdAt,
      this.updateAt,
      );

  @override
  // TODO: implement props
  List<Object> get props => [
    pinId,
    pinName,
    pinCourse,
    pinDeadline,
    pinDesc,
    pinImage,
    pinFile,
    addBy,
    createdAt,
    updateAt,
  ];
}