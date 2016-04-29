class Notification < ActiveRecord::Base
  belongs_to :activity, foreign_key: "activity_id"
  belongs_to :user, foreign_key: "user_id"

	# model: model instance
	# sender: who made the notification
	# recipients: people will receive notification
	def self.create(model, type, sender, recipients)
  		activity = model.create_activity type, owner: sender
  		recipients.each do |recipient|
  		  @notification = self.new
  		  @notification.activity_id = activity.id
        if recipient.is_a? Numeric
          @notification.user_id = recipient
        else
          @notification.user_id = recipient.id
        end
  		  @notification.status = 0
  		  @notification.save
  		end
	end
end
