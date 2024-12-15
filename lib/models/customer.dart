class Customer {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final int totalOrders;
  final double lifetimeValue;
  final bool isActive;
  final bool isNewCustomer;
  final ContactInfo contactInfo;
  final List<String> orderHistory;
  final PaymentStatus paymentStatus;

  Customer({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.totalOrders,
    required this.lifetimeValue,
    required this.isActive,
    required this.isNewCustomer,
    required this.contactInfo,
    required this.orderHistory,
    required this.paymentStatus,
  });
}

class ContactInfo {
  final String phone;
  final String address;
  final String city;
  final String country;

  ContactInfo({
    required this.phone,
    required this.address,
    required this.city,
    required this.country,
  });
}

enum PaymentStatus {
  good,
  pending,
  overdue
}
