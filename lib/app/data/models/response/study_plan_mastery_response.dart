class StudyPlanMasteryResponse {
  bool? success;
  String? message;
  StudyPlanMastery? data;

  StudyPlanMasteryResponse({
    this.success,
    this.message,
    this.data,
  });

  factory StudyPlanMasteryResponse.fromJson(Map<String, dynamic> json) =>
      StudyPlanMasteryResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : StudyPlanMastery.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class StudyPlanMastery {
  Map<String, dynamic>? mastery;

  StudyPlanMastery({this.mastery});

  factory StudyPlanMastery.fromJson(Map<String, dynamic> json) =>
      StudyPlanMastery(
        mastery: json["mastery"] == null
            ? null
            : Map<String, dynamic>.from(
                (json["mastery"]),
              ),
      );

  Map<String, dynamic> toJson() => {
        "mastery": mastery,
      };
}
