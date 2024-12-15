from .user import User, UserCreate, UserUpdate, UserInDB
from .product import Product, ProductCreate, ProductUpdate
from .customer import Customer, CustomerCreate, CustomerUpdate
from .order import Order, OrderCreate, OrderUpdate, OrderItem, OrderItemCreate
from pydantic import BaseModel

class Token(BaseModel):
    access_token: str
    token_type: str
