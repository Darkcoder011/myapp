from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from ..models.product import ProductStatus

class ProductBase(BaseModel):
    name: str
    sku: str
    description: Optional[str] = None
    price: float
    cost: float
    stock_quantity: int
    status: ProductStatus
    category: str
    image_url: Optional[str] = None

class ProductCreate(ProductBase):
    pass

class ProductUpdate(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None
    price: Optional[float] = None
    cost: Optional[float] = None
    stock_quantity: Optional[int] = None
    status: Optional[ProductStatus] = None
    category: Optional[str] = None
    image_url: Optional[str] = None

class ProductInDB(ProductBase):
    id: int
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True

class Product(ProductInDB):
    pass
