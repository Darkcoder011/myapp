import 'package:flutter/material.dart';
import '../models/order.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  OrderStatus? _selectedStatus;
  final _searchController = TextEditingController();
  
  // Sample data - replace with real data
  final List<Order> _orders = [
    Order(
      id: "ORD001",
      customerName: "John Doe",
      status: OrderStatus.pending,
      total: 299.99,
      orderDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Order(
      id: "ORD002",
      customerName: "Jane Smith",
      status: OrderStatus.shipped,
      total: 599.99,
      orderDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
    // Add more sample orders...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          _buildFiltersBar(),
          _buildQuickActions(),
          Expanded(
            child: _buildOrdersTable(),
          ),
          _buildPagination(),
        ],
      ),
    );
  }

  Widget _buildFiltersBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search orders...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          DropdownButton<OrderStatus>(
            value: _selectedStatus,
            hint: const Text('Filter by Status'),
            items: OrderStatus.values.map((status) {
              return DropdownMenuItem(
                value: status,
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Order.getStatusColor(status),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(Order.getStatusText(status)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (OrderStatus? newValue) {
              setState(() {
                _selectedStatus = newValue;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Create New Order'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () {
              // Handle create new order
            },
          ),
          const SizedBox(width: 16),
          OutlinedButton.icon(
            icon: const Icon(Icons.file_download),
            label: const Text('Export'),
            onPressed: () {
              // Handle export
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersTable() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
          columns: const [
            DataColumn(label: Text('Order ID')),
            DataColumn(label: Text('Customer')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Total')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Actions')),
          ],
          rows: _orders.map((order) {
            return DataRow(
              cells: [
                DataCell(Text(order.id)),
                DataCell(Text(order.customerName)),
                DataCell(_buildStatusBadge(order.status)),
                DataCell(Text('\$${order.total.toStringAsFixed(2)}')),
                DataCell(Text(DateFormat('MMM dd, yyyy').format(order.orderDate))),
                DataCell(_buildActionButtons()),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(OrderStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Order.getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Order.getStatusColor(status),
          width: 1,
        ),
      ),
      child: Text(
        Order.getStatusText(status),
        style: TextStyle(
          color: Order.getStatusColor(status),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.visibility, color: AppColors.primaryColor),
          onPressed: () {
            // Handle view
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: AppColors.secondaryColor),
          onPressed: () {
            // Handle edit
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: AppColors.errorColor),
          onPressed: () {
            // Handle delete
          },
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              // Handle previous page
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '1',
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              // Handle next page
            },
          ),
        ],
      ),
    );
  }
}
