import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/settings.dart';
import '../providers/theme_provider.dart';
import '../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _selectedTabIndex = 0;
  final _notificationSettings = NotificationSettings(
    orderStatusUpdates: true,
    paymentAlerts: true,
    lowStockAlerts: true,
    newCustomerAlerts: false,
  );

  final List<TeamMember> _teamMembers = [
    TeamMember(
      id: "TM001",
      name: "John Admin",
      email: "john@example.com",
      role: UserRole.admin,
      isActive: true,
    ),
    // Add more team members...
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Row(
        children: [
          _buildSettingsTabs(theme),
          Expanded(
            child: _buildSelectedTab(theme),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTabs(ThemeData theme) {
    return Container(
      width: 200,
      color: theme.colorScheme.surface,
      child: ListView(
        children: [
          _buildTab(0, 'User Management', Icons.people, theme),
          _buildTab(1, 'Preferences', Icons.settings, theme),
          _buildTab(2, 'Notifications', Icons.notifications, theme),
          _buildTab(3, 'Integrations', Icons.extension, theme),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title, IconData icon, ThemeData theme) {
    final isSelected = _selectedTabIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.6),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
    );
  }

  Widget _buildSelectedTab(ThemeData theme) {
    switch (_selectedTabIndex) {
      case 0:
        return _buildUserManagement(theme);
      case 1:
        return _buildPreferences(theme);
      case 2:
        return _buildNotifications(theme);
      case 3:
        return _buildIntegrations(theme);
      default:
        return const SizedBox();
    }
  }

  Widget _buildUserManagement(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Team Members', style: theme.textTheme.headlineMedium),
              ElevatedButton.icon(
                icon: const Icon(Icons.person_add),
                label: const Text('Add Member'),
                onPressed: () {
                  // Handle add member
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: _teamMembers.map((member) {
                return DataRow(
                  cells: [
                    DataCell(Text(member.name)),
                    DataCell(Text(member.email)),
                    DataCell(Text(member.role.toString().split('.').last)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: member.isActive
                              ? AppColors.accentColor.withOpacity(0.1)
                              : AppColors.errorColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          member.isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            color: member.isActive
                                ? AppColors.accentColor
                                : AppColors.errorColor,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Handle edit
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Handle delete
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferences(ThemeData theme) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Preferences', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPreferenceSection(
                    'Theme',
                    Row(
                      children: [
                        Icon(
                          themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          themeProvider.isDarkMode ? 'Dark Mode' : 'Light Mode',
                          style: theme.textTheme.titleMedium,
                        ),
                        const Spacer(),
                        Switch(
                          value: themeProvider.isDarkMode,
                          onChanged: (value) => themeProvider.toggleTheme(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  _buildPreferenceSection(
                    'Currency',
                    DropdownButton<String>(
                      value: 'USD',
                      items: const [
                        DropdownMenuItem(value: 'USD', child: Text('USD ($)')),
                        DropdownMenuItem(value: 'EUR', child: Text('EUR (€)')),
                        DropdownMenuItem(value: 'GBP', child: Text('GBP (£)')),
                      ],
                      onChanged: (value) {
                        // Handle currency change
                      },
                    ),
                  ),
                  const Divider(),
                  _buildPreferenceSection(
                    'Language',
                    DropdownButton<String>(
                      value: 'en',
                      items: const [
                        DropdownMenuItem(value: 'en', child: Text('English')),
                        DropdownMenuItem(value: 'es', child: Text('Spanish')),
                        DropdownMenuItem(value: 'fr', child: Text('French')),
                      ],
                      onChanged: (value) {
                        // Handle language change
                      },
                    ),
                  ),
                  const Divider(),
                  _buildPreferenceSection(
                    'Timezone',
                    DropdownButton<String>(
                      value: 'UTC',
                      items: const [
                        DropdownMenuItem(value: 'UTC', child: Text('UTC')),
                        DropdownMenuItem(
                          value: 'EST',
                          child: Text('Eastern Time (EST)'),
                        ),
                        DropdownMenuItem(
                          value: 'PST',
                          child: Text('Pacific Time (PST)'),
                        ),
                      ],
                      onChanged: (value) {
                        // Handle timezone change
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceSection(String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 200,
            child: Text(title, style: theme.textTheme.titleMedium),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildNotifications(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notification Settings', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildNotificationToggle(
                    'Order Status Updates',
                    'Receive notifications when order status changes',
                    _notificationSettings.orderStatusUpdates,
                    (value) {
                      setState(() {
                        _notificationSettings.orderStatusUpdates = value;
                      });
                    },
                  ),
                  const Divider(),
                  _buildNotificationToggle(
                    'Payment Alerts',
                    'Get notified about payment events',
                    _notificationSettings.paymentAlerts,
                    (value) {
                      setState(() {
                        _notificationSettings.paymentAlerts = value;
                      });
                    },
                  ),
                  const Divider(),
                  _buildNotificationToggle(
                    'Low Stock Alerts',
                    'Receive alerts when products are running low',
                    _notificationSettings.lowStockAlerts,
                    (value) {
                      setState(() {
                        _notificationSettings.lowStockAlerts = value;
                      });
                    },
                  ),
                  const Divider(),
                  _buildNotificationToggle(
                    'New Customer Alerts',
                    'Get notified when new customers register',
                    _notificationSettings.newCustomerAlerts,
                    (value) {
                      setState(() {
                        _notificationSettings.newCustomerAlerts = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildIntegrations(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Integrations', style: theme.textTheme.headlineMedium),
          const SizedBox(height: 24),
          _buildIntegrationSection(
            'Payment Gateways',
            [
              _buildIntegrationCard(
                'Stripe',
                'Connected',
                true,
                Icons.payment,
              ),
              _buildIntegrationCard(
                'PayPal',
                'Not Connected',
                false,
                Icons.payment,
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildIntegrationSection(
            'Third-Party Apps',
            [
              _buildIntegrationCard(
                'Google Analytics',
                'Connected',
                true,
                Icons.analytics,
              ),
              _buildIntegrationCard(
                'MailChimp',
                'Not Connected',
                false,
                Icons.mail,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntegrationSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: children,
        ),
      ],
    );
  }

  Widget _buildIntegrationCard(
    String title,
    String status,
    bool isConnected,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: isConnected ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              status,
              style: TextStyle(
                color: isConnected ? Theme.of(context).colorScheme.primary : Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Handle connection/disconnection
              },
              child: Text(isConnected ? 'Disconnect' : 'Connect'),
            ),
          ],
        ),
      ),
    );
  }
}
