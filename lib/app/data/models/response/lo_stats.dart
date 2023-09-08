class LoStatsResponse {
  bool? success;
  String? message;
  Data? data;

  LoStatsResponse({
    this.success,
    this.message,
    this.data,
  });

  factory LoStatsResponse.fromJson(Map<String, dynamic> json) =>
      LoStatsResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  User? user;

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  String? id;
  List<LoStat>? loStats;

  User({
    this.id,
    this.loStats,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        loStats: json["lo_stats"] == null
            ? []
            : List<LoStat>.from(
                json["lo_stats"]!.map((x) => LoStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "lo_stats": loStats == null
            ? []
            : List<dynamic>.from(loStats!.map((x) => x.toJson())),
      };
}

class LoStat {
  String? learningOutcome;
  int? progress;
  List<ProgressHistory>? progressHistory;

  LoStat({
    this.learningOutcome,
    this.progress,
    this.progressHistory,
  });

  factory LoStat.fromJson(Map<String, dynamic> json) => LoStat(
        learningOutcome: json["learning_outcome"],
        progress: json["progress"],
        progressHistory: json["progress_history"] == null
            ? []
            : List<ProgressHistory>.from(json["progress_history"]!
                .map((x) => ProgressHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "learning_outcome": learningOutcome,
        "progress": progress,
        "progress_history": progressHistory == null
            ? []
            : List<dynamic>.from(progressHistory!.map((x) => x.toJson())),
      };
}

class ProgressHistory {
  String? submissionId;
  int? progress;
  DateTime? createdAt;

  ProgressHistory({
    this.submissionId,
    this.progress,
    this.createdAt,
  });

  factory ProgressHistory.fromJson(Map<String, dynamic> json) =>
      ProgressHistory(
        submissionId: json["submission_id"],
        progress: json["progress"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "submission_id": submissionId,
        "progress": progress,
        "created_at": createdAt?.toIso8601String(),
      };
}
