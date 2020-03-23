class Ip {
  String origin;

  Ip(this.origin);

  Ip.fromJson(Map<String, dynamic> json) : origin = json['origin'];

  Map<String, dynamic> toJson() => {"origin": origin};
}
