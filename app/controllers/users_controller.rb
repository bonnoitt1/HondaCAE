class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show, :index]
  before_action :correct_user, only: [:edit, :update, :show]
  def show
     @user = User.find(params[:id])
     @all_groups = Group.all
     #@user_memberships = Membership.find(:all, :conditions => [ "user_id = ? AND is_confirmed = ?", current_user.id, 'true'])
     @user_memberships = Membership.where(:user_id => @user.id, :is_confirmed => true)
     @admin_pending_memberships = Membership.where(:is_confirmed => false)
     @user_pending_memberships = Membership.where(:user_id => @user.id, :is_confirmed => false)
     if is_group_admin? and not is_admin?
	@admingroups = Group.where(:owner_id => @user.id)
	#@blahs = Group.group(:type).map {|e| e[:type]}
        
      	@groupadmin_pending_memberships = Membership.where(:group_id => @admingroups, :is_confirmed => false)
	#groupadmin_pending_memberships = Membership
     end
  end

  def new
    if signed_in?
	redirect_to current_user
    else
     @user = User.new
    end
  end

  def join_group
	@user = User.find(params[:id])
	@group = Group.find(params[:groupid])
	@membership = Membership.new(:user_id=>@user.id, :group_id=>@group.id, :owner=>false, :is_confirmed=>false)
	respond_to do |format|
	      	if @membership.save
			format.html { redirect_to @user, notice: 'Your request was successfully sent.' }
			format.json { render action: 'show', status: :created, location: @membership }
	      	else
			format.html { redirect_to @user, notice: 'Sorry there was an error.' }
			format.json { render json: @membership.errors, status: :unprocessable_entity }
	      	end
    	end	
  end

  def accept_membership
	@user = User.find(params[:id])	
	@membership = Membership.find(params[:memid])
	@membership.update(:is_confirmed => true)
	respond_to do |format|
	      	if @membership.save
			format.html { redirect_to @user, notice: 'User request was successfully accepted.' }
			format.json { render action: 'show', status: :created, location: @membership }
	      	else
			format.html { redirect_to @user, notice: 'Sorry there was an error.' }
			format.json { render json: @membership.errors, status: :unprocessable_entity }
	      	end
    	end
  end


  def edit
  end

  def index
	@user = User.find_by_id(current_user[:id])
	if @user.id<=5
		@users = User.all
	else
		redirect_to current_user, :notice => "You dont have the appropriate permission to view that page!"
	end
  end
  def update
    if @user.update_attributes(user_params)
       flash[:success] = "Profile updated"
       redirect_to @user
    else 
       render 'edit', :notice => "Error updating profile try again!"
    end
  end
  def create
     @user = User.new(user_params)
       if @user.save
          sign_in @user
          flash[:success] = "Welcome to the Get Healthy Website!"
           redirect_to @user
       else 
          render 'new'
     end
  end

private 
    def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
    def membership_params
	params.require(:user).permit(:user_id, :group_id, :owner)
    end
    def signed_in_user
        #store_location
        #redirect_to signin_url, notice: "PLease sign in." unless signed_in?
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(current_user, :notice => "You tried to access a wrong link, please try again!") unless current_user?(@user)
    end
end
