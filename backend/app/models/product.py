from sqlalchemy import Column, Integer, String, Float, Boolean, DateTime, Enum as SQLEnum
from sqlalchemy.sql import func
from ..database import Base
import enum

class ProductStatus(str, enum.Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
    OUT_OF_STOCK = "out_of_stock"

class Product(Base):
    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(255))
    sku = Column(String(50), unique=True, index=True)
    description = Column(String(1000))
    price = Column(Float)
    cost = Column(Float)
    stock_quantity = Column(Integer)
    status = Column(SQLEnum(ProductStatus))
    category = Column(String(255))
    image_url = Column(String(500))
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())
