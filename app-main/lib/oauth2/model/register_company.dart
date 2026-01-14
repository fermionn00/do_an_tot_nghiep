import 'package:json_annotation/json_annotation.dart';

part 'register_company.g.dart';

@JsonSerializable()
class RegisterCompany {
  final String? name;
  final String? representativeName;
  final String? employeeCode;
  final String? address;
  final int? categoryCode;
  final int? statusCode;
  final double? latitude;
  final double? longitude;
  final int? typeCheckLogin;
  final int? typeWork;
  final double? maxDistance;
  final int? companyCode;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  const RegisterCompany({
    this.firstName,
    this.lastName,
    this.employeeCode,
    this.name,
    this.representativeName,
    this.address,
    this.categoryCode,
    this.statusCode,
    this.latitude,
    this.longitude,
    this.typeCheckLogin,
    this.typeWork,
    this.maxDistance,
    this.companyCode,
    this.email,
    this.password,
  });

  factory RegisterCompany.fromJson(Map<String, dynamic> json) =>
      _$RegisterCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterCompanyToJson(this);
}
