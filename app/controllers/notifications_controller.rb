class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def index
	  @notifications = Notification.where("user_id = #{current_user.id}")
	  @js = { notifications: [] }
	  @notifications.each do |notification|
	  	controller = notification.activity.key.split(".").first
	  	action = notification.activity.key.split(".").last
	  	@js[:notifications] << { id: notification.id, message: render_to_string(partial: "public_activity/#{controller}/#{action}", locals: { :activity => notification.activity }) }
	  end
	  render json: @js
	end
end