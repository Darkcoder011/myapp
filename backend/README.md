# Accounting App Backend

This is the backend service for the Accounting Application built with FastAPI.

## Features

- User Authentication and Authorization
- Product Management
- Customer Management
- Order Processing
- Advanced Reporting
- Settings Management

## Tech Stack

- FastAPI
- SQLAlchemy
- Alembic (Database Migrations)
- PyMySQL
- JWT Authentication
- Pydantic for data validation

## Setup Instructions

1. Create a virtual environment:
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

4. Run database migrations:
```bash
alembic upgrade head
```

5. Start the development server:
```bash
uvicorn app.main:app --reload
```

## API Documentation

Once the server is running, you can access:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## API Endpoints

### Authentication
- POST /api/v1/login/access-token - Get access token
- POST /api/v1/test-token - Test token validity

### Users
- GET /api/v1/users - List users
- POST /api/v1/users - Create user
- GET /api/v1/users/{user_id} - Get user details
- PUT /api/v1/users/{user_id} - Update user
- DELETE /api/v1/users/{user_id} - Delete user

### Products
- GET /api/v1/products - List products
- POST /api/v1/products - Create product
- GET /api/v1/products/{product_id} - Get product details
- PUT /api/v1/products/{product_id} - Update product
- DELETE /api/v1/products/{product_id} - Delete product

### Customers
- GET /api/v1/customers - List customers
- POST /api/v1/customers - Create customer
- GET /api/v1/customers/{customer_id} - Get customer details
- PUT /api/v1/customers/{customer_id} - Update customer
- DELETE /api/v1/customers/{customer_id} - Delete customer

### Orders
- GET /api/v1/orders - List orders
- POST /api/v1/orders - Create order
- GET /api/v1/orders/{order_id} - Get order details
- PUT /api/v1/orders/{order_id} - Update order
- DELETE /api/v1/orders/{order_id} - Delete order

### Reports
- GET /api/v1/reports/revenue - Revenue reports
- GET /api/v1/reports/top-products - Top products report
- GET /api/v1/reports/customer-segments - Customer segmentation
- GET /api/v1/reports/sales-by-category - Sales by category
- GET /api/v1/reports/inventory-status - Inventory status

## Environment Variables

Create a `.env` file in the root directory with the following variables:

```env
DATABASE_URL=mysql+pymysql://root:password@localhost/accounting_db
SECRET_KEY=your-secret-key-here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
```

## Development

### Database Migrations

To create a new migration:
```bash
alembic revision --autogenerate -m "Description of changes"
```

To apply migrations:
```bash
alembic upgrade head
```

To rollback migrations:
```bash
alembic downgrade -1
```
