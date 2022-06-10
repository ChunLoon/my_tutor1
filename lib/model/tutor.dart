class listTutors{
 String? tutorId;
  String?  tutorName;
  String? tutorDesc;
  String?  tutorEmail;
  String?  tutorPhone;
  String?  tutorPass;
  String?  tutorDatereg;

 listTutors(
      {this. tutorId,
      this.tutorName,
      this.tutorDesc,
      this. tutorEmail,
      this. tutorPhone,
      this. tutorPass,
      this. tutorDatereg
      });

  listTutors.fromJson(Map<String, dynamic> json) {
   tutorId = json['tutor_id'];
   tutorName = json['tutor_name'];
   tutorDesc = json['tutor_description'];
    tutorEmail = json['tutor_email'];
    tutorPhone = json['tutor_phone'];
    tutorPass = json['tutor_password'];
    tutorDatereg = json['tutor_datereg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tutor_id'] = tutorId;
    data['tutor_name'] =  tutorName;
    data['tutor_description'] =  tutorDesc;
    data['tutor_email'] = tutorEmail;
    data['tutor_phone'] =  tutorPhone;
    data['tutor_password'] =  tutorPass;
     data['tutor_datereg']= tutorDatereg;
    return data;
  }
}


