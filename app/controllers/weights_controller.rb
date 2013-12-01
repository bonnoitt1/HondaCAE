class WeightsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @weights = @user.weights.paginate(page: params[:page])
  end  
  def index
    	@user = User.find_by_id(current_user[:id])
	if @user.id<=5
		@weight = @user.weights.build 
      		@log_items_weights = @user.log_weight.paginate(page: params[:page])
	else
		redirect_to current_user, :notice => "You dont have the appropriate permission to view that page!"
	end
  end

   
  def create
     @weight = current_user.weights.build(weight_params)
       if @weight.save
           flash[:success] = "Weight Added"
           redirect_to(:back)
       else 
          @log_items_weights = []
       #render 'goals/goals'
       render 'new'
     end
  end
  def new
    @user = User.new
    if signed_in?
      @weight = current_user.weights.build 
      @log_items_weights = current_user.log_weight.paginate(page: params[:page])
    else
	redirect_to signin_path, :notice => "Please sign in first"
    end
  end

  def destroy
    @weight.destroy
    redirect_to(:back)
  end

private 
    def weight_params
	#params.fetch(:goal, {})
       params.require(:weight).permit(:weight) if params[:weight]
    end
    def correct_user
     @user = User.find(params[:id])
      redirect_to(current_user, :notice => "You tried to access a wrong link, please try again!") unless current_user?(@user)
    end
end