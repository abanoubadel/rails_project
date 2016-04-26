class UsersController < ApplicationController
  before_action :authenticate_user!, only: []
  before_action :correct_user,   only: []
  autocomplete :user, :name, :full => true

  def index
    @users = User.paginate(page: params[:page])
    if params[:search]
      @users = User.name_like("%#{params[:search]}%").order('name').paginate(page: params[:page])
    else
    end
  end

  def show
    @user = User.find(params[:id])
  end

  

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
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
