class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders=[]
    @orders << Order.find_by_owner_id(current_user.id)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def invitations
    @orders = current_user.orders
  end

  # GET /orders/new
  before_action :authenticate_user!

  def new
    @owner = current_user
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    # render json: params
    # return
    restaurant_id = params.fetch(:id)
    orderItems=[]
    params.fetch(:data).each do |id, count|
      orderItems << ItemsOrder.new(item_id: id.to_s, amount: count)
    end
    order = Order.new(restaurant_id: restaurant_id)
    order.items_orders << orderItems
    order.description = "new order"
    order.status = 0
    order.meal = "lunch"
    order.owner = current_user
    invited_users =[]
    invited_users << User.find_by_name(params.fetch('users'))
    puts '------------------------------------------------' + invited_users.inspect + '------------------------------------------------'
    order.users << invited_users
    if order.save
      Notification.create(order, :create, current_user, invited_users)
      redirect_to :back
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      @order.description = order_params['description']
      @order.meal = order_params['meal'].to_i
      @order.items =Item.find order_params['items'].take_while { |i| i.to_i > 0 }
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.fetch(:order)
  end
end
