class RestaurantsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :make_order, :join_order]
  before_action :is_allowed_to_join?, :only => :join_order

  def index
    @restaurants = Restaurant.all
  end

  def show
    @groupList=current_user.groups.select('name').map { |g| g.name+'(group)' }
    @userList= current_user.followed_users.select("name").map { |u| u.name } + @groupList
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.items.all
    @order = Order.new
  end

  def make_order
  end

  def join_order
    @restaurant = @order.restaurant
    @items = @restaurant.items.all
    flash[:notice]='You can add your items to order'
  end


  private
  def is_allowed_to_join?
    begin
      order_id = params.fetch(:id)
      @order = Order.find(order_id)
      if !@order.is_user_allowed? current_user
        flash[:error]="you aren't invited to this order"
        redirect_to :root
      elsif @order.closed?
        flash[:error]='sorry this order has been closed'
        redirect_to :root
      end
    rescue ActiveRecord::RecordNotFound
      flash[:error]="Not found"
      redirect_to root_path
    end
  end
end

