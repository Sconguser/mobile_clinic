import 'package:clinic_mobile/services/procedures_provider.dart';


class MedicalProcedure{
  int id;
  String name;
  int doctorId;
  int duration;

  MedicalProcedure({this.id, this.name, this.doctorId, this.duration,});
  factory MedicalProcedure.fromJson(Map<String,dynamic>body){
    return MedicalProcedure(
      id:body['id'],
      name:body['name'],
      doctorId: body['doctor_id'],
      duration:body['duration']
    );
  }
}