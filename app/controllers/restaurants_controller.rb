class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.items.all
    @order = Order.new
  end

  def make_order
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
    order.users << current_user
    if order.save
       redirect_to :back
    else
      redirect_to root_path

    end
  end
end
