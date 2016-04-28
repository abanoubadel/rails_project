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

  end
end
