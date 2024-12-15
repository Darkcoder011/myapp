from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from ....database import get_db
from ....schemas.order import Order, OrderCreate, OrderUpdate
from ....models.order import Order as OrderModel, OrderItem
from ..deps import get_current_active_user
from ....models.user import User

router = APIRouter()

@router.get("/", response_model=List[Order])
def read_orders(
    db: Session = Depends(get_db),
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(get_current_active_user)
):
    orders = db.query(OrderModel).offset(skip).limit(limit).all()
    return orders

@router.post("/", response_model=Order)
def create_order(
    order_in: OrderCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    # Create order
    order = OrderModel(
        customer_id=order_in.customer_id,
        status=order_in.status,
        payment_status=order_in.payment_status,
        total_amount=order_in.total_amount,
        tax_amount=order_in.tax_amount,
        discount_amount=order_in.discount_amount,
        shipping_amount=order_in.shipping_amount,
        net_amount=order_in.net_amount,
        shipping_address=order_in.shipping_address,
        billing_address=order_in.billing_address,
        notes=order_in.notes,
        order_number=f"ORD-{db.query(OrderModel).count() + 1:06d}"
    )
    db.add(order)
    db.commit()
    db.refresh(order)

    # Create order items
    for item in order_in.items:
        order_item = OrderItem(
            order_id=order.id,
            **item.dict()
        )
        db.add(order_item)
    
    db.commit()
    db.refresh(order)
    return order

@router.put("/{order_id}", response_model=Order)
def update_order(
    order_id: int,
    order_in: OrderUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    order = db.query(OrderModel).filter(OrderModel.id == order_id).first()
    if not order:
        raise HTTPException(
            status_code=404,
            detail="Order not found"
        )
    
    update_data = order_in.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(order, field, value)
    
    db.add(order)
    db.commit()
    db.refresh(order)
    return order

@router.get("/{order_id}", response_model=Order)
def read_order(
    order_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    order = db.query(OrderModel).filter(OrderModel.id == order_id).first()
    if not order:
        raise HTTPException(
            status_code=404,
            detail="Order not found"
        )
    return order

@router.delete("/{order_id}")
def delete_order(
    order_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_active_user)
):
    order = db.query(OrderModel).filter(OrderModel.id == order_id).first()
    if not order:
        raise HTTPException(
            status_code=404,
            detail="Order not found"
        )
    
    # Delete associated order items first
    db.query(OrderItem).filter(OrderItem.order_id == order_id).delete()
    
    db.delete(order)
    db.commit()
    return {"message": "Order deleted successfully"}
