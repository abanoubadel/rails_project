class UsersController < ApplicationController
  before_action :authenticate_user!, only: []
  before_action :correct_user,   only: []
  autocomplete :user, :name, :full => true
  respond_to :html, :js

  def index
    @users = User.paginate(page: params[:page]).where.not(id: current_user)
    if params[:search]
      @users = User.name_like("%#{params[:search]}%").order('name').paginate(page: params[:page])
    else
    end
  end

  def show
    @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: params[:id])
    begin
      @user = User.find(params[:id])
    rescue Exception => e
       logger.debug "#{e.class}"
       redirect_to root_url
    end
  end


  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :phone, :bio)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end
