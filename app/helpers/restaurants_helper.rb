module RestaurantsHelper
  def disabled?
    !@order.is_owner? current_user
  end

  def menu_action
    if is_invitation?
      'join_order_update'
    else
      'create'
    end
  end

  alias :is_invitation? :disabled?

end
