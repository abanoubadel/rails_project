class GroupsController < ApplicationController

  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:destroy]

  def index
    user=User.find(current_user.id)
    @groups= user.groups
  end

  def new
    @group = Group.new
    @group_owner = User.find(current_user.id)
    @friends =  @group_owner.followed_users
  end

  def create
    begin
      @group_owner = User.find(current_user.id)
      @friends =  @group_owner.followed_users
      @group = Group.new(group_params)
      @group_owner.groups << @group
      if @group.save(validate: false)
        flash[:notice] = 'Group Created'
        redirect_to groups_path
      else
        render 'new'
      end
    rescue Exception => e
      logger.debug "#{e.class}"
      flash[:notice] = 'Grop name is Already exist'
      render 'new'
    end
  end


  def edit
    @group_owner = User.find(current_user.id)
    @friends =  @group_owner.followed_users
    @group = Group.find(params[:id])
  end

  def update
    begin
      @group_owner = User.find(current_user.id)
      @friends =  @group_owner.followed_users
      @group = Group.find(params[:id])
      if @group.update(group_params)
         @group_owner.groups << @group
        flash[:notice] = 'Group Updated'
        redirect_to groups_path
      else
        render 'new'
      end
    rescue Exception => e
      logger.debug "#{e.class}"
      flash[:notice] = 'Grop name is Already exist'
      render 'new'
    end
  end


  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = 'Group Removed'
    redirect_to groups_path
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

  	def group_params
    	params.require(:group).permit(:name, :description, :group_admin_id, :group_image, :user_ids => [])
  	end
end