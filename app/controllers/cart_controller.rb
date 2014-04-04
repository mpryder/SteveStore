class CartController < ApplicationController
  before_filter :authenticate_user!
  
  
  def add
    id = params[:id]

    cart = session[:cart] ||= {}
    cart[id] = (cart[id] || 0) + 1

    redirect_to :action => :index
  end

  def index
    @cart = session[:cart] || {}
  end

    def change
    cart = session[:cart]
    id = params[:id];
    quantity = params[:quantity].to_i
    if cart and cart[id]
      unless quantity <= 0
        cart[id] = quantity
      else
        cart.delete id
      end
    end
    redirect_to :action => :index
  end

  def remove 
    cart = session[:cart]    
    id = params[:id]     
    cart.delete id               
    redirect_to :action => :index   
  end
   
  def clearCart     
    session[:cart] = nil     
    redirect_to :action => :index   
  end 
  
   def createOrder        
     @user = User.find(current_user.id) 
     profile = Profile.find_by_id(current_user.id)         
     # Create a new order and associate it with the current user     
     @order = @user.orders.build(:order_date => DateTime.now, :firstname => profile.firstname, 
     :lastname => profile.lastname, :address => profile.address, :mobile => profile.mobile)     
     @order.save          
     # For each item in the cart, create a new item on the order!!     
     @cart = session[:cart] || {} 
     # Get the content of the Cart     
     @cart.each do | id, quantity |      
       product = Product.find_by_id(id)      
       @orderitem = @order.orderitems.build(:product_id => product.id, :name => product.name, 
       :description => product.description, :quantity => quantity, :price => product.price)      
       @orderitem.save
          
       end 
       session[:cart] = nil
      redirect_to @order, notice: "Order complete"
       
   end
  
  def destroy
    @cart = session[:cart] || {}
    @cart.destroy
  end

end
