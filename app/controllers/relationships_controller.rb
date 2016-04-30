class RelationshipsController < ApplicationController
 before_action :authenticate_user!, only [:create, :destroy]

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    Notification.create(@user, :follow, current_user, [@user])
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    Notification.create(@user, :unfollow, current_user, [@user])
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
