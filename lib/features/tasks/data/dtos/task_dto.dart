class TaskDto {
  final int userId;
  final int id;
  final String title;
  final String body;

  TaskDto({required this.userId, required this.id, required this.title, required this.body});

  factory TaskDto.fromJson(Map<String, dynamic> json) {
    return TaskDto(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}