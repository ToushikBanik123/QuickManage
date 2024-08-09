class Task {
  final int userId;
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String priority;
  final String status;
  final int assignedUserId;

  Task({
    required this.userId,
    required this.id,
    required this.title,
    this.description = '', // Default empty string if not provided
    required this.dueDate,
    this.priority = 'Medium', // Default to 'Medium' if not provided
    required this.status,
    this.assignedUserId = 0, // Default to 0 if not provided
  });

  // Factory constructor for creating a new Task instance from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    // Parse 'completed' to 'status' for backward compatibility
    String status = json['completed'] != null
        ? (json['completed'] ? 'Done' : 'To-Do')
        : 'To-Do';

    return Task(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      // description: '',
      description: json['description'] ?? '',
      dueDate: DateTime.now(), // Default to current time if not available
      priority: 'Medium', // Default value
      status: status,
      assignedUserId: 0, // Default value
    );
  }

  // Method to convert Task instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'priority': priority,
      'status': status,
      'assignedUserId': assignedUserId,
    };
  }
}

