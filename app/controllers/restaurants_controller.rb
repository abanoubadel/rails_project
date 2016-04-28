class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  def index
    @restaurants = Restaurant.all
  end

  def show
    @userList= current_user.followed_users.select("name").map {|u| u.name}
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.items.all
    @order = Order.new
  end

  def make_order
    # render json: params
    # return
    restaurant_id = params.fetch(:id)
    orderItems=[]
    params.fetch(:data).each do  |id,count|
      orderItems << ItemsOrder.new(item_id:id.to_s , amount:count )
    end
    order = Order.new(restaurant_id: restaurant_id)
    order.items_orders << orderItems
    order.description = "new order"
    order.status = 0
    order.meal = "lunch"
    order.owner = current_user
    order.users << User.find_by_name(params.fetch('users'));
    if order.save
       redirect_to :back
    else
      redirect_to root_path

    end
  end
end
