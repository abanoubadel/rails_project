class ProviderSessionsController < ApplicationController
	def create
    	
    	auth = request.env["omniauth.auth"]
   		user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      	sign_in user
      	redirect_back_or user
	end


end
