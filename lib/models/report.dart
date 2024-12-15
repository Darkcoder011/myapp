enum ReportType {
  revenue,
  customer,
  product
}

enum TimeRange {
  last7Days,
  lastMonth,
  lastYear,
  custom
}

class ReportData {
  final ReportType type;
  final TimeRange timeRange;
  final DateTime? customStartDate;
  final DateTime? customEndDate;
  final List<DataPoint> data;

  ReportData({
    required this.type,
    required this.timeRange,
    this.customStartDate,
    this.customEndDate,
    required this.data,
  });
}

class DataPoint {
  final DateTime date;
  final String label;
  final double value;
  final String? category;

  DataPoint({
    required this.date,
    required this.label,
    required this.value,
    this.category,
  });
}

class TopProduct {
  final String name;
  final int quantity;
  final double revenue;

  TopProduct({
    required this.name,
    required this.quantity,
    required this.revenue,
  });
}

class CustomerSegment {
  final String name;
  final int count;
  final double percentage;
  final Color color;

  CustomerSegment({
    required this.name,
    required this.count,
    required this.percentage,
    required this.color,
  });
}
