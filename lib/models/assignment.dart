part of 'models.dart';

class Assignment extends Equatable{
  final String assignId;
  final String assignName;
  final String assignCourse;
  final String assignDeadline;
  final String assignDesc;
  final String assignImage;
  final String assignFile;
  final String addBy;
  final String createdAt;
  final String updateAt;

  Assignment(
      this.assignId,
      this.assignName,
      this.assignCourse,
      this.assignDeadline,
      this.assignDesc,
      this.assignImage,
      this.assignFile,
      this.addBy,
      this.createdAt,
      this.updateAt,
      );

  @override
  // TODO: implement props
  List<Object> get props => [
    assignId,
    assignName,
    assignCourse,
    assignDeadline,
    assignDesc,
    assignImage,
    assignFile,
    addBy,
    createdAt,
    updateAt,
  ];
}