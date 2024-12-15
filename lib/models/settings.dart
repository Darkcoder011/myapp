enum UserRole {
  admin,
  manager,
  staff
}

class TeamMember {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final bool isActive;

  TeamMember({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
  });
}

class AppPreferences {
  final String currency;
  final String timezone;
  final String language;
  final NotificationSettings notifications;
  final IntegrationSettings integrations;

  AppPreferences({
    required this.currency,
    required this.timezone,
    required this.language,
    required this.notifications,
    required this.integrations,
  });
}

class NotificationSettings {
  final bool orderStatusUpdates;
  final bool paymentAlerts;
  final bool lowStockAlerts;
  final bool newCustomerAlerts;

  NotificationSettings({
    required this.orderStatusUpdates,
    required this.paymentAlerts,
    required this.lowStockAlerts,
    required this.newCustomerAlerts,
  });
}

class IntegrationSettings {
  final List<PaymentGateway> paymentGateways;
  final List<ThirdPartyApp> connectedApps;

  IntegrationSettings({
    required this.paymentGateways,
    required this.connectedApps,
  });
}

class PaymentGateway {
  final String name;
  final bool isActive;
  final String apiKey;

  PaymentGateway({
    required this.name,
    required this.isActive,
    required this.apiKey,
  });
}

class ThirdPartyApp {
  final String name;
  final bool isConnected;
  final DateTime? lastSync;

  ThirdPartyApp({
    required this.name,
    required this.isConnected,
    this.lastSync,
  });
}
