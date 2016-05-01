class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :invitations, :new, :edit, :create, :update, :destroy]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :ensure_items, only: [:create, :join_order_update]
  # GET /orders
  # GET /orders.json
  def index
    @orders=[]
    @orders = Order.where("owner_id = #{current_user.id}")

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
    restaurant_id = params.fetch(:id)
    order_data= params.fetch('order')
    order = Order.new(restaurant_id: restaurant_id)
    order.items_orders << order_items
    order.description = order_data['description']
    order.status = 0
    order.meal = order_data['meal']
    order.owner = current_user
    invited_users =[]

    #this sql shoud be optmized
    if (params.has_key?('groups'))
      invited_groups = []
      invited_groups << Group.find_by_name(params.fetch('groups'))
      invited_groups.each do |group|
        invited_users += group.users;
      end
    end

    if (params.has_key?('users'))
      invited_users << User.find_by_name(params.fetch('users'))
    end
    order.users << invited_users

    if order.save
      Notification.create(order, :create, current_user, invited_users)
      flash[:notice] = "Order successfully created"
      redirect_to :back
    else
      flash[:notice] = "Order  error"
      redirect_to :back
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      @order.description = order_params['description']
      @order.meal = order_params['meal'].to_i
      @order.items =Item.find order_params['item_ids'].take_while { |i| i.to_i > 0 }
      @order.status = order_params['status']
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

  def join_order_update
    @order = set_order
    @order.items_orders << order_items
    if @order.save
      flash[:notice]='done!'
    else
      flash[:notice]='failed!'
    end
    redirect_to :root
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

  def order_items()
    order_items=[]
    params.fetch(:order_items).each do |id, count|
      order_items << ItemsOrder.new(item_id: id.to_s,
                                    amount: count,
                                    user_id: current_user.id)
    end
    order_items

  end

  def ensure_items
    if (!params.has_key?('order_items'))
      flash[:notice]='cant creat blank order'
      redirect_to :back
      return false
    end
  end

end
