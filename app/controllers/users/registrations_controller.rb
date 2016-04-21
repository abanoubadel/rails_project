
module Users
	class Users::RegistrationsController < Devise::RegistrationsController

	  private

	  def sign_up_params
	  	 devise_parameter_sanitizer.sanitize(:sign_up)
	    params.require(:user).permit(:email, :displayname, :bio, :phone, :password, :password_confirmation)
	  end

	  def account_update_params
	  	devise_parameter_sanitizer.sanitize(:account_update)
	    params.require(:user).permit(:email, :displayname, :bio, :phone, :password, :password_confirmation, :current_password)
	  end
	end
end