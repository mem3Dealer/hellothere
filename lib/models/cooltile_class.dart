import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final Random rnd = Random();
const _chars = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz";

class Cooltile {
  // поля
  String title;
  int subtitle;
  dynamic id;

  Cooltile({
    this.title,
    this.subtitle,
    this.id,
  });

  void toggleSubtitle(int coef, bool encrease) {
    // метод
    if (encrease) {
      subtitle = subtitle * 2;
    } else {
      subtitle = subtitle ~/ 2;
    }
  }

  void splitTitle() {
    // method
    List lst = title.split("");
    lst.shuffle();
    title = lst.join();
  }

  Cooltile copyWith({
    // const
    String title,
    int subtitle,
    int id,
  }) {
    return Cooltile(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    //method?
    return {
      'title': title,
      'subtitle': subtitle,
      'id': id,
    };
  }

  factory Cooltile.fromMap(Map<String, dynamic> map) {
    //constructor
    if (map == null) return null;

    return Cooltile(
      title: map['title'],
      subtitle: map['subtitle'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap()); //method?

  //constructor
  factory Cooltile.fromJson(String source) =>
      Cooltile.fromMap(json.decode(source));

  //method
  @override
  String toString() => 'Cooltile(title: $title, subtitle: $subtitle, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Cooltile &&
        o.title == title &&
        o.subtitle == subtitle &&
        o.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode ^ id.hashCode;
}

int randNumb() {
  return rnd.nextInt(100) + 100;
}

String randomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));
