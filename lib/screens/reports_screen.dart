import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/report.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  ReportType _selectedReportType = ReportType.revenue;
  TimeRange _selectedTimeRange = TimeRange.last7Days;
  DateTimeRange? _customDateRange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildTimeRangeSelector(),
                        const SizedBox(height: 24),
                        _buildCharts(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          _buildSidebarItem(
            'Revenue Reports',
            ReportType.revenue,
            Icons.monetization_on,
          ),
          _buildSidebarItem(
            'Customer Reports',
            ReportType.customer,
            Icons.people,
          ),
          _buildSidebarItem(
            'Product Reports',
            ReportType.product,
            Icons.inventory,
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(String title, ReportType type, IconData icon) {
    final isSelected = _selectedReportType == type;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {
        setState(() {
          _selectedReportType = type;
        });
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Advanced Reports',
            style: AppTextStyles.headerLarge,
          ),
          Row(
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.file_download),
                label: const Text('Export'),
                onPressed: () {
                  _showExportDialog();
                },
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.email),
                label: const Text('Email Report'),
                onPressed: () {
                  // Handle email report
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _buildTimeRangeChip(TimeRange.last7Days, 'Last 7 Days'),
            const SizedBox(width: 8),
            _buildTimeRangeChip(TimeRange.lastMonth, 'Last Month'),
            const SizedBox(width: 8),
            _buildTimeRangeChip(TimeRange.lastYear, 'Last Year'),
            const SizedBox(width: 8),
            _buildTimeRangeChip(TimeRange.custom, 'Custom Range'),
            if (_selectedTimeRange == TimeRange.custom) ...[
              const SizedBox(width: 16),
              TextButton(
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _customDateRange = picked;
                    });
                  }
                },
                child: Text(
                  _customDateRange != null
                      ? '${DateFormat('MMM d, y').format(_customDateRange!.start)} - '
                          '${DateFormat('MMM d, y').format(_customDateRange!.end)}'
                      : 'Select Dates',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeChip(TimeRange range, String label) {
    return ChoiceChip(
      label: Text(label),
      selected: _selectedTimeRange == range,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedTimeRange = range;
            if (range != TimeRange.custom) {
              _customDateRange = null;
            }
          });
        }
      },
    );
  }

  Widget _buildCharts() {
    return Column(
      children: [
        _buildRevenueChart(),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(child: _buildTopProductsChart()),
            const SizedBox(width: 24),
            Expanded(child: _buildCustomerSegmentsChart()),
          ],
        ),
      ],
    );
  }

  Widget _buildRevenueChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Revenue Trends', style: AppTextStyles.headerMedium),
            const SizedBox(height: 24),
            SizedBox(
              height: 300,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        const FlSpot(0, 3),
                        const FlSpot(1, 1),
                        const FlSpot(2, 4),
                        const FlSpot(3, 2),
                      ],
                      isCurved: true,
                      color: AppColors.primaryColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primaryColor.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProductsChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Products', style: AppTextStyles.headerMedium),
            const SizedBox(height: 24),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 15,
                          color: AppColors.primaryColor,
                          width: 22,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            topRight: Radius.circular(4),
                          ),
                        ),
                      ],
                    ),
                    // Add more sample data...
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerSegmentsChart() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer Segments', style: AppTextStyles.headerMedium),
            const SizedBox(height: 24),
            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      color: AppColors.primaryColor,
                      value: 40,
                      title: '40%',
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Add more sample data...
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Export as PDF'),
              onTap: () {
                Navigator.pop(context);
                // Handle PDF export
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: const Text('Export as CSV'),
              onTap: () {
                Navigator.pop(context);
                // Handle CSV export
              },
            ),
          ],
        ),
      ),
    );
  }
}
