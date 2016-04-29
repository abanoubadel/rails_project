class RestaurantsController < ApplicationController
  before_action :authenticate_user!

  def index
    @restaurants = Restaurant.all
  end

  def show
    @userList= current_user.followed_users.select("name").map { |u| u.name }
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.items.all
    @order = Order.new
  end

  def make_order
  end

  def join_order
    order_id = params.fetch(:order_id)
    @order = Order.find order_id
    @restaurant = @order.restaurant
    @items = @restaurant.items.all
    flash[:notice]="add your items to order"
    render 'restaurants/show'
  end
end
