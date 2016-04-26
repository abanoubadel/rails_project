ActiveAdmin.register Restaurant do

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
 permit_params :name, :phone, :location, :menu_image, :phone

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :phone
      f.input :location
      f.input :menu_image, :as => :file
      f.input :phone, :as => :phone
    end
    f.button "create"
  end

end
