class HemobancoAddress {
  final int id;
  final String address;

  HemobancoAddress({ required this.id, required this.address});

  factory HemobancoAddress.fromJson(Map<String, dynamic> json) {
    return HemobancoAddress(
      id: json['id'] ?? 0,
      address: json['address'] ?? '',
    );
  }
}
