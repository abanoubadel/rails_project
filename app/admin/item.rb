ActiveAdmin.register Item do
  remove_filter :items_orders
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
  permit_params :name, :price , :comment, :image,:restaurant_id

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :restaurant_id,
              :as => :select,
              :collection => Restaurant.all.collect {|restaurant| [restaurant.name, restaurant.id] }
      f.input :name
      f.input :price
      f.input :comment
      f.input :image, :as => :file
    end
    f.button "create"
  end


end
