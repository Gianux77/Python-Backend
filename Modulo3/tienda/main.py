# py =  MODULO u SCRIPT

from flask import Flask
from flask import render_template # si o si importamos para que el index html pueda funcionar
from flask import request # para formularios
from flask import session # dic
from flask import redirect # lo redirecciona a otra pagina

# importamos lo que es de la bases de datos
from database import User
from database import Products

#blueprint

app = Flask(__name__)
app.secret_key = "bootcamp_codigofacilito"


@app.route("/")
def index():
 return render_template("index.html")

# --GET : obtener informacion por medio del servidor, ej:imagen,videos.
# --POST : cuando enviamos informacion al servidor para que se almacene, ej: reiniciando la sesion, obtener datos.

@app.route("/register", methods = ["GET","POST"])
def register():
    if request.method == "POST":
        print(request.form) # devuelve un diccionario
        
        _email = request.form.get("email")
        _password = request.form.get("password")
        
        #print(email)
        #print(password)
        
        if _email and _password:
            user = User.create_user(_email, _password) # VIENE DE METODO DE CLASE, DE DATABASE
            session[ "user" ] = user.id # hace referencia al id del usuario de la base de datos.
            return redirect("/products")  #lo redirige a la session products
        
    
    return render_template("register.html")

@app.route("/products")
def products():
    
    user = User.get(session["user"])
    _products = Products.select().where(Products.user == user)
    
    
    
    return render_template("/products/index.html", products=_products)

#EN PRODUCTOS LOS CREAMOS

@app.route("/products/create", methods=["GET","POST"])
def products_create():
    if request.method == "POST":                   #importante el form tiene que tener un post
        _name  =  request.form.get("name")
        _price = request.form.get("price")
        _user  = User.get(session[ "user" ])
    
        if _name and _price:
         products = Products.create_product(_name, _price, _user)
         return redirect("/products") 
    
    return render_template("products/create.html")


#EN PRODUCTOS LOS ACTUALIZAMOS

@app.route("/products/update/<id>", methods=["GET","POST"])
def products_update(id):
    _product = Products.select().where(Products.id == id).first()
    
    if request.method == "POST":
        _product.name = request.form.get("name")
        _product.price = request.form.get("price")
        _product.save() # UPDATE guarda y actualiza el products.
        
    
        return redirect("/products")   
    
    
    return render_template("products/update.html", product=_product )

# ELIMINAMOS EL PRODUCTO.
@app.route("/products/delete/<id>", methods=["GET","POST"])
def products_delete(id):
    _product = Products.get_or_none(Products.id == id)

    if _product:
        _product.delete_instance()
        return redirect("/products")

    return "Producto no encontrado", 404
    


if __name__ == "__main__":
  app.run(debug=True) ## Esto sirve para que el servidor se actualize automatico.