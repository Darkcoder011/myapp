from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
from ..models.order import OrderStatus, PaymentStatus

class OrderItemBase(BaseModel):
    product_id: int
    quantity: int
    unit_price: float
    total_price: float

class OrderItemCreate(OrderItemBase):
    pass

class OrderItemInDB(OrderItemBase):
    id: int
    order_id: int
    created_at: datetime

    class Config:
        from_attributes = True

class OrderBase(BaseModel):
    customer_id: int
    status: OrderStatus
    payment_status: PaymentStatus
    total_amount: float
    tax_amount: float
    discount_amount: float
    shipping_amount: float
    net_amount: float
    shipping_address: str
    billing_address: str
    notes: Optional[str] = None

class OrderCreate(OrderBase):
    items: List[OrderItemCreate]

class OrderUpdate(BaseModel):
    status: Optional[OrderStatus] = None
    payment_status: Optional[PaymentStatus] = None
    shipping_address: Optional[str] = None
    billing_address: Optional[str] = None
    notes: Optional[str] = None

class OrderInDB(OrderBase):
    id: int
    order_number: str
    created_at: datetime
    updated_at: Optional[datetime] = None
    items: List[OrderItemInDB]

    class Config:
        from_attributes = True

class Order(OrderInDB):
    pass
