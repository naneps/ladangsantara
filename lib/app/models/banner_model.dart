import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/models/store_model.dart';

class BannerModel {
  int? id;
  int? userId;
  String? externalId;
  String? imagePath;
  String? experationAt;
  String? bankCode;
  int? status;
  String? createdAt;
  String? updatedAt;
  User? user;
  BannerModel(
      {this.id,
      this.userId,
      this.externalId,
      this.imagePath,
      this.experationAt,
      this.user,
      this.bankCode,
      this.status,
      this.createdAt,
      this.updatedAt});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    externalId = json['external_id'];
    imagePath = json['image_path'];
    experationAt = json['experation_at'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['external_id'] = externalId;
    data['image_path'] = imagePath;
    data['experation_at'] = experationAt;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toCreate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_path'] = imagePath;
    data['bank_code'] = bankCode;
    return data;
  }

  String? get billingTime {
    final date = DateTime.parse(createdAt!);
    return "${date.day} ${date.month} ${date.year}";
  }

  String getCountdownTime() {
    final createdDate = DateTime.parse(createdAt!);
    final expirationDate = DateTime.parse(experationAt!);

    final countdown = expirationDate.difference(createdDate);
    final formattedCountdown = countdown.toString().split('.').first;

    return formattedCountdown;
  }

  String get createdAtFormatted {
    return Utils.dMYFormat(createdAt!);
  }

  String get experationAtFormatted {
    return Utils.dayMonthFormatter(experationAt!);
  }
}

class User {
  int? id;
  String? name;
  String? email;
  void emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;
  StoreModel? store;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.store});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (store != null) {
      data['store'] = store!.toJson();
    }
    return data;
  }
}
