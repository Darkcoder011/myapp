from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy import func
from typing import List, Dict
from datetime import datetime, timedelta
from ....database import get_db
from ....models.order import Order, OrderItem
from ....models.product import Product
from ....models.customer import Customer
from ..deps import get_current_active_user
from ....models.user import User

router = APIRouter()

@router.get("/revenue")
def get_revenue_report(
    start_date: datetime,
    end_date: datetime,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    revenue_data = db.query(
        func.date(Order.created_at).label('date'),
        func.sum(Order.total_amount).label('revenue'),
        func.count(Order.id).label('order_count')
    ).filter(
        Order.created_at.between(start_date, end_date)
    ).group_by(
        func.date(Order.created_at)
    ).all()

    return {
        "data": [
            {
                "date": data.date,
                "revenue": float(data.revenue),
                "order_count": data.order_count
            }
            for data in revenue_data
        ]
    }

@router.get("/top-products")
def get_top_products_report(
    start_date: datetime,
    end_date: datetime,
    limit: int = 10,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    top_products = db.query(
        Product.name,
        func.sum(OrderItem.quantity).label('total_quantity'),
        func.sum(OrderItem.total_price).label('total_revenue')
    ).join(
        OrderItem
    ).join(
        Order
    ).filter(
        Order.created_at.between(start_date, end_date)
    ).group_by(
        Product.id
    ).order_by(
        func.sum(OrderItem.total_price).desc()
    ).limit(limit).all()

    return {
        "data": [
            {
                "product_name": product.name,
                "total_quantity": product.total_quantity,
                "total_revenue": float(product.total_revenue)
            }
            for product in top_products
        ]
    }

@router.get("/customer-segments")
def get_customer_segments_report(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    segments = {
        "new": db.query(func.count(Customer.id)).filter(
            Customer.created_at >= datetime.now() - timedelta(days=30)
        ).scalar(),
        "active": db.query(func.count(Customer.id)).filter(
            Customer.last_purchase_date >= datetime.now() - timedelta(days=90)
        ).scalar(),
        "at_risk": db.query(func.count(Customer.id)).filter(
            Customer.last_purchase_date.between(
                datetime.now() - timedelta(days=180),
                datetime.now() - timedelta(days=90)
            )
        ).scalar(),
        "lost": db.query(func.count(Customer.id)).filter(
            Customer.last_purchase_date < datetime.now() - timedelta(days=180)
        ).scalar()
    }

    return segments

@router.get("/sales-by-category")
def get_sales_by_category(
    start_date: datetime,
    end_date: datetime,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    sales_data = db.query(
        Product.category,
        func.sum(OrderItem.total_price).label('total_revenue'),
        func.count(OrderItem.id).label('total_sales')
    ).join(
        OrderItem
    ).join(
        Order
    ).filter(
        Order.created_at.between(start_date, end_date)
    ).group_by(
        Product.category
    ).all()

    return {
        "data": [
            {
                "category": data.category,
                "total_revenue": float(data.total_revenue),
                "total_sales": data.total_sales
            }
            for data in sales_data
        ]
    }

@router.get("/inventory-status")
def get_inventory_status(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    inventory_data = db.query(
        Product.category,
        func.sum(Product.stock_quantity).label('total_stock'),
        func.count(Product.id).label('product_count'),
        func.sum(Product.stock_quantity * Product.cost).label('inventory_value')
    ).group_by(
        Product.category
    ).all()

    return {
        "data": [
            {
                "category": data.category,
                "total_stock": data.total_stock,
                "product_count": data.product_count,
                "inventory_value": float(data.inventory_value)
            }
            for data in inventory_data
        ]
    }
