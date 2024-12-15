class RevenueData {
  final DateTime date;
  final double amount;
  final double growth;

  RevenueData(this.date, this.amount, this.growth);
}

class RevenueStream {
  final String source;
  final double amount;
  final double percentage;

  RevenueStream(this.source, this.amount, this.percentage);
}

class AbandonmentRate {
  final double rate;
  final double revenueLoss;
  final double yearOverYear;

  AbandonmentRate(this.rate, this.revenueLoss, this.yearOverYear);
}

class SalesFunnel {
  final int sessions;
  final int carts;
  final int orders;

  SalesFunnel(this.sessions, this.carts, this.orders);
}

class SalesBreakdown {
  final double cost;
  final double netProfit;
  final double shippingFees;
  final double taxes;
  final double paypalFees;

  SalesBreakdown(this.cost, this.netProfit, this.shippingFees, this.taxes, this.paypalFees);
}
