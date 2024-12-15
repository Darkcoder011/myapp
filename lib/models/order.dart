enum OrderStatus {
  pending,
  shipped,
  delivered,
  canceled
}

class Order {
  final String id;
  final String customerName;
  final OrderStatus status;
  final double total;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.customerName,
    required this.status,
    required this.total,
    required this.orderDate,
  });

  static Color getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return const Color(0xFFFFA726); // Orange
      case OrderStatus.shipped:
        return const Color(0xFF42A5F5); // Blue
      case OrderStatus.delivered:
        return const Color(0xFF66BB6A); // Green
      case OrderStatus.canceled:
        return const Color(0xFFEF5350); // Red
    }
  }

  static String getStatusText(OrderStatus status) {
    return status.toString().split('.').last.toUpperCase();
  }
}
