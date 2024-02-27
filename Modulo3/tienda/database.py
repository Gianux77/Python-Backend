from peewee import *
from decouple import config
import datetime

database = MySQLDatabase(
    "tienda",
    user="root",
    password=config("DBPASS"), # YA NO ESTA EN EL CODIGO, LA PASSWORD ESTA EN EL SERVIDOR.
    port=3306,
    host="localhost"
)


class User(Model): # Creamos una tabla
    # id: ya sea crea predeterminado
    email = TextField()
    password = TextField()
    created_at= DateTimeField(default=datetime.datetime.now)
    
    
    class Meta:
        database    = database  # el modelo se conecta -->> la base de datos --> database
        db_table    = "users"
        
    @classmethod                                       # CREAMOS UN METODO DE CLASE
    def create_user(cls, email, password):
        #nuestro algoritmo encryp
        return User.create(email=email, password=password)
        
class Products(Model):
    
    name = TextField()
    price = TextField()
    user = ForeignKeyField(User, backref="products")
    created_at= DateTimeField(default=datetime.datetime.now)
    
    
    class Meta:
        database    = database  # el modelo se conecta -->> la base de datos --> database
        db_table    = "products" 
        
    @classmethod                                       # CREAMOS UN METODO DE CLASE
    def create_product(cls, name, price, user):
        #nuestro algoritmo encryp
        return Products.create(name=name, price=price, user=user)        

database.create_tables( [User, Products] )