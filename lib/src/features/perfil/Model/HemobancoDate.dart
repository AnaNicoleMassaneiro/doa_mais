class HemobancoDate {
  final int id;
  final List<AvailableDate> availableDates;
  final HemobancoAddress hemobancoAddress;
  final int hemobancoAddressId;

  HemobancoDate({
    required this.id,
    required this.availableDates,
    required this.hemobancoAddress,
    required this.hemobancoAddressId,
  });
}

class AvailableDate {
  final int id;
  final List<AvailableTimeSlot> availableTimeSlots;
  final String date;

  AvailableDate({
    required this.id,
    required this.availableTimeSlots,
    required this.date,
  });
}

class AvailableTimeSlot {
  final int id;
  final String time;

  AvailableTimeSlot({
    required this.id,
    required this.time,
  });
}

class HemobancoAddress {
  final int id;
  final String address;
  final String city;
  final String state;
  final String zipCode;

  HemobancoAddress({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
  });
}
