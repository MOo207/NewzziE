// To parse this JSON data, do
//
//     final localUser = localUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LocalUser localUserFromJson(String str) => LocalUser.fromJson(json.decode(str));

String localUserToJson(LocalUser data) => json.encode(data.toJson());

class LocalUser {
    LocalUser({
        @required this.displayName,
        @required this.email,
        @required this.emailVerified,
        @required this.isAnonymous,
        @required this.metadata,
        @required this.phoneNumber,
        @required this.photoUrl,
        @required this.providerData,
        @required this.refreshToken,
        @required this.tenantId,
        @required this.uid,
    });

    final String displayName;
    final String email;
    final String emailVerified;
    final String isAnonymous;
    final String metadata;
    final String phoneNumber;
    final String photoUrl;
    final String providerData;
    final String refreshToken;
    final String tenantId;
    final String uid;

    factory LocalUser.fromJson(Map<String, dynamic> json) => LocalUser(
        displayName: json["displayName"] == null ? null : json["displayName"],
        email: json["email"] == null ? null : json["email"],
        emailVerified: json["emailVerified"] == null ? null : json["emailVerified"],
        isAnonymous: json["isAnonymous"] == null ? null : json["isAnonymous"],
        metadata: json["metadata"] == null ? null : json["metadata"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        photoUrl: json["photoURL"] == null ? null : json["photoURL"],
        providerData: json["providerData"] == null ? null : json["providerData"],
        refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
        tenantId: json["tenantId"] == null ? null : json["tenantId"],
        uid: json["uid"] == null ? null : json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "displayName": displayName == null ? null : displayName,
        "email": email == null ? null : email,
        "emailVerified": emailVerified == null ? null : emailVerified,
        "isAnonymous": isAnonymous == null ? null : isAnonymous,
        "metadata": metadata == null ? null : metadata,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "photoURL": photoUrl == null ? null : photoUrl,
        "providerData": providerData == null ? null : providerData,
        "refreshToken": refreshToken == null ? null : refreshToken,
        "tenantId": tenantId == null ? null : tenantId,
        "uid": uid == null ? null : uid,
    };
}
