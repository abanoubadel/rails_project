class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def index
	  @notifications = Notification.where("user_id = #{current_user.id}")
	  @counter = Notification.where("user_id = #{current_user.id} and status = 0").count
	  @js = { notifications: [], count: @counter }
	  @notifications.each do |notification|
	  	controller = notification.activity.key.split(".").first
	  	action = notification.activity.key.split(".").last
	  	@js[:notifications] << { id: notification.id, message: render_to_string(partial: "public_activity/#{controller}/#{action}", locals: { :activity => notification.activity }), status: notification.status }
	  end
	  render json: @js
	end
end