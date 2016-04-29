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
 permit_params :name, :phone, :location, :menu_image, :phone,:logo ,:description

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :location
      f.input :description ,:as => :text
      f.input :menu_image, :as => :file
      f.input :logo, :as => :file
      f.input :phone, :as => :phone
    end
    f.button "create"
  end

end
