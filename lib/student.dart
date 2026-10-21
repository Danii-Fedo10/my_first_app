class Student {
  String name;
  List<int> scores;

  Student(this.name, this.scores);

  double get average {
    if (scores.isEmpty) return 0;
    int sum = 0;
    for (var s in scores) {
      sum += s;
    }
    return sum / scores.length;
  }

  String get grade {
    if (average >= 90) return 'A';
    if (average >= 80) return 'B';
    if (average >= 70) return 'C';
    if (average >= 60) return 'D';
    return 'F';
  }

  Map<String, dynamic> toJson() => {'name': name, 'scores': scores};

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      json['name'] as String,
      List<int>.from(json['scores'] as List),
    );
  }
}
