class Device {
  String type;
  bool playable;
  dynamic cost;

  bool get console => cost >= 35000 && playable;
  set disPrice(double val) => cost = cost - (cost * val);

  showData() => console
      ? 'it is $type, it costs $cost and it is console'
      : 'it is $type, it costs $cost and you can`t play videogames on it';
  Device(
    this.type,
    this.cost,
    this.playable,
  );
  Device.named(this.cost, this.playable);
}

void main() {
  var playstation = Device('PS4', 35000, true);
  var iphone = Device('iPhone', 80000, false);
  var nokia = Device.named(7000, false);

  iphone.disPrice = 0.3;
  print(nokia.showData());
}
