class listSubjects{

  String? subjectId;
  String? subjectName;
  String?subjectDesc;
  String? subjectPrice;
  String? tutorId;
  String? subjectSessions;
  String? subjectRating;

 listSubjects(
      {this.subjectId,
      this.subjectName,
      this.subjectPrice,
      this.tutorId,
      this.subjectSessions,
      this.subjectRating});

  listSubjects.fromJson(Map<String, dynamic> json) {
   subjectId = json['subject_id'];
   subjectName = json['subject_name'];
   subjectDesc = json['subject_description'];
    tutorId = json['tutor_id'];
    subjectPrice = json['subject_price'];
    subjectSessions = json['subject_sessions'];
    subjectRating = json['subject_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject_id'] = subjectId;
    data['subject_name'] = subjectName;
    data['tutor_id'] = subjectDesc;
    data['subject_price'] = tutorId;
    data['subject_sessions'] =  subjectSessions;
    data['subject_rating'] = subjectRating;
    return data;
  }
}


