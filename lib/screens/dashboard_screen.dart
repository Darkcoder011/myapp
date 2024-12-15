import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import '../models/dashboard_data.dart';
import '../widgets/revenue_chart.dart';
import '../utils/constants.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildRevenueSection(),
            const SizedBox(height: 20),
            _buildMetricsGrid(),
            const SizedBox(height: 20),
            _buildSalesFunnel(),
            const SizedBox(height: 20),
            _buildSalesBreakdown(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Container(
        width: 300,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            prefixIcon: const Icon(Icons.search),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ),
      actions: [
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: 5, end: 5),
          badgeContent: const Text(
            '3',
            style: TextStyle(color: Colors.white),
          ),
          child: const Icon(Icons.notifications_outlined),
        ),
        const SizedBox(width: 20),
        const CircleAvatar(
          backgroundImage: NetworkImage('https://placeholder.com/150'),
          radius: 15,
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Dashboard Overview',
      style: AppTextStyles.headerLarge,
    );
  }

  Widget _buildRevenueSection() {
    // Sample data - replace with real data
    final revenueData = [
      RevenueData(DateTime.now().subtract(const Duration(days: 6)), 1000, 5),
      RevenueData(DateTime.now().subtract(const Duration(days: 5)), 1200, 7),
      RevenueData(DateTime.now().subtract(const Duration(days: 4)), 900, -2),
      RevenueData(DateTime.now().subtract(const Duration(days: 3)), 1500, 15),
      RevenueData(DateTime.now().subtract(const Duration(days: 2)), 1300, 8),
      RevenueData(DateTime.now().subtract(const Duration(days: 1)), 1800, 20),
      RevenueData(DateTime.now(), 2000, 25),
    ];

    return RevenueChart(data: revenueData);
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildMetricCard(
          'Revenue Streams',
          '\$15,234',
          Icons.monetization_on_outlined,
          AppColors.primaryColor,
        ),
        _buildMetricCard(
          'Abandonment Rate',
          '24.5%',
          Icons.shopping_cart_outlined,
          AppColors.errorColor,
        ),
        _buildMetricCard(
          'Net Profit',
          '\$8,456',
          Icons.trending_up,
          AppColors.accentColor,
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 10),
          Text(title, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 5),
          Text(value, style: AppTextStyles.headerMedium),
        ],
      ),
    );
  }

  Widget _buildSalesFunnel() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sales Funnel', style: AppTextStyles.headerMedium),
          const SizedBox(height: 20),
          _buildFunnelStep('Sessions', '10,234', 1.0),
          _buildFunnelStep('Shopping Carts', '5,678', 0.7),
          _buildFunnelStep('Orders Placed', '2,345', 0.4),
        ],
      ),
    );
  }

  Widget _buildFunnelStep(String label, String value, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.bodyMedium),
              Text(value, style: AppTextStyles.bodyLarge),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesBreakdown() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sales Breakdown', style: AppTextStyles.headerMedium),
          const SizedBox(height: 20),
          _buildBreakdownItem('Cost', 5000, Colors.red[300]!),
          _buildBreakdownItem('Net Profit', 8000, Colors.green[300]!),
          _buildBreakdownItem('Shipping Fees', 1000, Colors.blue[300]!),
          _buildBreakdownItem('Taxes', 1500, Colors.orange[300]!),
          _buildBreakdownItem('PayPal Fees', 500, Colors.purple[300]!),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(label, style: AppTextStyles.bodyMedium),
            ],
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}
