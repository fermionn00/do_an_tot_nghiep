// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterCompany _$RegisterCompanyFromJson(Map<String, dynamic> json) =>
    RegisterCompany(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      employeeCode: json['employee_code'] as String?,
      name: json['name'] as String?,
      representativeName: json['representative_name'] as String?,
      address: json['address'] as String?,
      categoryCode: json['category_code'] as int?,
      statusCode: json['status_code'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      typeCheckLogin: json['type_check_login'] as int?,
      typeWork: json['type_work'] as int?,
      maxDistance: (json['max_distance'] as num?)?.toDouble(),
      companyCode: json['company_code'] as int?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterCompanyToJson(RegisterCompany instance) =>
    <String, dynamic>{
      'name': instance.name,
      'representative_name': instance.representativeName,
      'employee_code': instance.employeeCode,
      'address': instance.address,
      'category_code': instance.categoryCode,
      'status_code': instance.statusCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'type_check_login': instance.typeCheckLogin,
      'type_work': instance.typeWork,
      'max_distance': instance.maxDistance,
      'company_code': instance.companyCode,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'password': instance.password,
    };
