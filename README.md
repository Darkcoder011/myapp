# Accounting App

A modern, full-stack accounting application built with Flutter and FastAPI.

## 🌟 Features

### 📊 Dashboard
- Real-time revenue graphs with animations
- Sales funnel visualization
- Key performance indicators
- Interactive metrics cards

### 📦 Products Management
- Grid/List view toggle
- Real-time search and filtering
- Stock management
- Price history tracking

### 👥 Customer Management
- Customer profiles
- Purchase history
- Lifetime value tracking
- Communication history

### 📋 Orders
- Order creation and tracking
- Status management
- Payment integration
- Invoice generation

### 📈 Reports
- Revenue analytics
- Product performance
- Customer segments
- Inventory status

### ⚙️ Settings
- User management
- Theme customization (Dark/Light)
- Notification preferences
- Integration settings

## 🎨 UI/UX Features

### 🌓 Theme Support
- Light and Dark theme
- Smooth theme transition animations
- Customizable color schemes
- Consistent design language

### 📱 Responsive Design
- Desktop-first approach
- Adaptive layouts
- Flexible components
- Touch-friendly interfaces

### 🎭 Animations
- Page transitions
- Chart animations
- Loading states
- Interactive feedback

## 🎨 Global Design Enhancements

### Typography
- Primary Font: "Inter" for clean, modern interface elements
- Secondary Font: "Poppins" for headings and emphasis
- Font Weights: Regular (400), Medium (500), and Bold (600)
- Line Heights: 1.5 for body text, 1.2 for headings

### Color Palette
- Primary Colors:
  - White (#FFFFFF) - Main background
  - Deep Blue (#3A57E8) - Primary actions and highlights
  - Soft Gradient (Blue → Purple) - Accent elements
- Status Colors:
  - Success Green (#00C48C)
  - Error Red (#FF4D4F)
  - Warning Orange (#FAAD14)
  - Info Blue (#1890FF)
- Neutral Colors:
  - Gray Scale: #F5F5F5 → #141414
  - Background Tints: rgba(58, 87, 232, 0.1)

### Interactive States
- Hover Effects:
  - Buttons: Scale(1.02) + brightness increase
  - Cards: Elevation increase (2dp → 4dp)
  - Table Rows: Background tint + subtle scale
- Active States:
  - Buttons: Darken primary color by 10%
  - Form Elements: Blue outline (#3A57E8)
- Focus States:
  - Keyboard focus ring with high contrast
  - 2px solid outline in primary color

### Shadows & Elevation
- Card Shadow: `0 2px 8px rgba(0, 0, 0, 0.05)`
- Dropdown Shadow: `0 4px 12px rgba(0, 0, 0, 0.1)`
- Modal Shadow: `0 8px 24px rgba(0, 0, 0, 0.12)`
- Hover Shadow: `0 6px 16px rgba(0, 0, 0, 0.08)`

### Tooltips & Popovers
- Background: White with 2px border radius
- Shadow: `0 2px 8px rgba(0, 0, 0, 0.15)`
- Arrow indicator for direction
- Max width: 250px
- Padding: 8px 12px

### Accessibility Features
- ARIA Labels:
  - Interactive elements
  - Form controls
  - Dynamic content updates
- Color Contrast:
  - WCAG 2.1 AA compliance
  - Minimum 4.5:1 for normal text
  - Minimum 3:1 for large text
- Focus Indicators:
  - Visible keyboard focus states
  - Skip navigation links
  - Proper heading hierarchy

### Animation & Transitions
- Duration: 200ms for micro-interactions
- Timing: Ease-in-out for smooth motion
- Transform Origin: Based on interaction point
- Scale Transitions: 0.97 → 1.0 for press states

### Spacing System
- Base Unit: 4px
- Common Spacing:
  - XS: 4px
  - SM: 8px
  - MD: 16px
  - LG: 24px
  - XL: 32px
  - XXL: 48px

### Border Radius
- Small: 4px (buttons, chips)
- Medium: 8px (cards, modals)
- Large: 12px (floating panels)
- Circular: 50% (avatars, icons)

## 🏗️ Project Structure

```
accounting_app/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── dashboard_data.dart
│   │   ├── order.dart
│   │   ├── product.dart
│   │   ├── customer.dart
│   │   ├── report.dart
│   │   └── settings.dart
│   ├── screens/
│   │   ├── dashboard_screen.dart
│   │   ├── orders_screen.dart
│   │   ├── products_screen.dart
│   │   ├── customers_screen.dart
│   │   ├── reports_screen.dart
│   │   └── settings_screen.dart
│   ├── widgets/
│   │   ├── revenue_chart.dart
│   │   ├── sales_funnel.dart
│   │   └── metrics_card.dart
│   ├── providers/
│   │   └── theme_provider.dart
│   ├── theme/
│   │   └── app_theme.dart
│   └── utils/
│       └── constants.dart
└── backend/
    ├── app/
    │   ├── main.py
    │   ├── api/
    │   │   └── v1/
    │   │       ├── endpoints/
    │   │       │   ├── users.py
    │   │       │   ├── products.py
    │   │       │   ├── customers.py
    │   │       │   ├── orders.py
    │   │       │   └── reports.py
    │   │       └── api.py
    │   ├── core/
    │   │   ├── config.py
    │   │   └── security.py
    │   ├── models/
    │   │   ├── user.py
    │   │   ├── product.py
    │   │   ├── customer.py
    │   │   └── order.py
    │   └── schemas/
    │       ├── user.py
    │       ├── product.py
    │       ├── customer.py
    │       └── order.py
    └── alembic/
        └── versions/
```

## 🚀 Getting Started

### Frontend Setup

1. Install Flutter dependencies:
```bash
flutter pub get
```

2. Run the app:
```bash
flutter run -d chrome  # For web
flutter run            # For desktop/mobile
```

### Backend Setup

1. Create virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up the database:
```bash
# Create MySQL database
mysql -u root -p
CREATE DATABASE accounting_db;
```

4. Run migrations:
```bash
alembic upgrade head
```

5. Start the server:
```bash
uvicorn app.main:app --reload
```

## 🔄 API Endpoints

### Authentication
- POST `/api/v1/login/access-token`
- POST `/api/v1/test-token`

### Users
- GET `/api/v1/users`
- POST `/api/v1/users`
- GET `/api/v1/users/{user_id}`
- PUT `/api/v1/users/{user_id}`
- DELETE `/api/v1/users/{user_id}`

### Products
- GET `/api/v1/products`
- POST `/api/v1/products`
- GET `/api/v1/products/{product_id}`
- PUT `/api/v1/products/{product_id}`
- DELETE `/api/v1/products/{product_id}`

### Customers
- GET `/api/v1/customers`
- POST `/api/v1/customers`
- GET `/api/v1/customers/{customer_id}`
- PUT `/api/v1/customers/{customer_id}`
- DELETE `/api/v1/customers/{customer_id}`

### Orders
- GET `/api/v1/orders`
- POST `/api/v1/orders`
- GET `/api/v1/orders/{order_id}`
- PUT `/api/v1/orders/{order_id}`
- DELETE `/api/v1/orders/{order_id}`

### Reports
- GET `/api/v1/reports/revenue`
- GET `/api/v1/reports/top-products`
- GET `/api/v1/reports/customer-segments`
- GET `/api/v1/reports/sales-by-category`
- GET `/api/v1/reports/inventory-status`

## 🎨 Animations

The app includes various animations for enhanced user experience:

### Page Transitions
- Fade transitions between screens
- Slide transitions for modal dialogs
- Scale transitions for cards

### Chart Animations
- Progressive line chart drawing
- Bar chart value animations
- Pie chart rotation and selection

### Interactive Elements
- Button hover effects
- Card hover elevations
- Ripple effects
- Loading spinners

### Theme Switching
- Smooth color transitions
- Icon morphing
- Background transitions

## 🔐 Security Features

### Authentication
- JWT-based authentication
- Role-based access control
- Secure password hashing
- Token refresh mechanism

### Data Protection
- Input validation
- SQL injection prevention
- XSS protection
- CORS configuration

## 📱 Responsive Design

The app is fully responsive and adapts to different screen sizes:

### Desktop
- Full sidebar navigation
- Multi-column layouts
- Hover interactions
- Keyboard shortcuts

### Tablet
- Collapsible sidebar
- Adaptive grid layouts
- Touch-friendly controls
- Optimized spacing

### Mobile
- Bottom navigation
- Single column layouts
- Swipe gestures
- Mobile-optimized forms

## 🛠️ Development Tools

### Frontend
- Flutter SDK
- Provider for state management
- fl_chart for data visualization
- shared_preferences for local storage

### Backend
- FastAPI framework
- SQLAlchemy ORM
- Alembic migrations
- PyMySQL database driver

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.
