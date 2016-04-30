class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :make_order, :join_order]
  before_action :is_allowed_to_join?, :only => :join_order

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
    @restaurant = @order.restaurant
    @items = @restaurant.items.all
    flash[:notice]='add your items to order'
  end


  private
  def is_allowed_to_join?
    order_id = params.fetch(:id)
    @order = Order.find order_id
    if !@order.is_user_allowed? current_user
      flash[:notice]="you aren't invited to this order"
      redirect_to :root
    end
  end
end
