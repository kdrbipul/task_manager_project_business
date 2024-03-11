class TaskListWrapper {
  String? status;
  List<TaskItem>? taskList;

  TaskListWrapper({this.status, this.taskList});

  TaskListWrapper.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = <TaskItem>[];
      json['data'].forEach((v) {
        taskList!.add(TaskItem.fromJson(v));
      });
    }
  }
}

class TaskItem {
  String? sId;
  String? title;
  String? description;
  String? status;
  String? createdDate;

  TaskItem({this.sId, this.title, this.description, this.status, this.createdDate});

  TaskItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['createdDate'] = createdDate;
    return data;
  }
}
