import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../utils/constants.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final _searchController = TextEditingController();
  Customer? _selectedCustomer;
  bool? _activeFilter;
  bool? _newCustomerFilter;

  // Sample data - replace with real data
  final List<Customer> _customers = [
    Customer(
      id: "CUS001",
      name: "John Doe",
      email: "john@example.com",
      avatarUrl: "https://placeholder.com/150",
      totalOrders: 5,
      lifetimeValue: 499.99,
      isActive: true,
      isNewCustomer: false,
      contactInfo: ContactInfo(
        phone: "+1234567890",
        address: "123 Main St",
        city: "New York",
        country: "USA",
      ),
      orderHistory: ["ORD001", "ORD002"],
      paymentStatus: PaymentStatus.good,
    ),
    // Add more sample customers...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildHeader(),
                _buildFilters(),
                Expanded(child: _buildCustomerTable()),
              ],
            ),
          ),
          if (_selectedCustomer != null)
            Expanded(
              flex: 1,
              child: _buildCustomerDetails(_selectedCustomer!),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle add new customer
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search customers...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
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

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          DropdownButton<bool?>(
            value: _activeFilter,
            hint: const Text('Status'),
            items: const [
              DropdownMenuItem(value: null, child: Text('All')),
              DropdownMenuItem(value: true, child: Text('Active')),
              DropdownMenuItem(value: false, child: Text('Inactive')),
            ],
            onChanged: (value) {
              setState(() {
                _activeFilter = value;
              });
            },
          ),
          const SizedBox(width: 16),
          DropdownButton<bool?>(
            value: _newCustomerFilter,
            hint: const Text('Customer Type'),
            items: const [
              DropdownMenuItem(value: null, child: Text('All')),
              DropdownMenuItem(value: true, child: Text('New')),
              DropdownMenuItem(value: false, child: Text('Returning')),
            ],
            onChanged: (value) {
              setState(() {
                _newCustomerFilter = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerTable() {
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
          columns: const [
            DataColumn(label: Text('Customer ID')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Total Orders')),
            DataColumn(label: Text('Lifetime Value')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: _customers.map((customer) {
            return DataRow(
              cells: [
                DataCell(Text(customer.id)),
                DataCell(Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(customer.avatarUrl!),
                      radius: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(customer.name),
                  ],
                )),
                DataCell(Text(customer.email)),
                DataCell(Text(customer.totalOrders.toString())),
                DataCell(Text('\$${customer.lifetimeValue.toStringAsFixed(2)}')),
                DataCell(_buildStatusBadge(customer)),
                DataCell(
                  IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _selectedCustomer = customer;
                      });
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(Customer customer) {
    Color color;
    String text;

    if (customer.paymentStatus == PaymentStatus.good) {
      color = AppColors.accentColor;
      text = 'Good';
    } else if (customer.paymentStatus == PaymentStatus.pending) {
      color = Colors.orange;
      text = 'Pending';
    } else {
      color = AppColors.errorColor;
      text = 'Overdue';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }

  Widget _buildCustomerDetails(Customer customer) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(customer.avatarUrl!),
                radius: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(customer.name, style: AppTextStyles.headerLarge),
                    Text(customer.email, style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _selectedCustomer = null;
                  });
                },
              ),
            ],
          ),
          const Divider(height: 32),
          Text('Contact Information', style: AppTextStyles.headerMedium),
          const SizedBox(height: 16),
          _buildInfoRow('Phone', customer.contactInfo.phone),
          _buildInfoRow('Address', customer.contactInfo.address),
          _buildInfoRow('City', customer.contactInfo.city),
          _buildInfoRow('Country', customer.contactInfo.country),
          const Divider(height: 32),
          Text('Order History', style: AppTextStyles.headerMedium),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: customer.orderHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(customer.orderHistory[index]),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Handle order details navigation
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
          Text(value, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
