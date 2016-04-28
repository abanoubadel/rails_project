class StaticPagesController < ApplicationController

  before_action :authenticate_user!, only: [:index]

  def index
      @activities = PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.followed_users, owner_type: "User")
  end

  def home
  end

  def help
  end

  def about
  end

  def contact
  end
end
