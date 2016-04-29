module RestaurantsHelper
  def disabled?
    !@order.is_owner? current_user
  end
end
