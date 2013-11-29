class GoalsController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    @goals = @user.goals.paginate(page: params[:page])
  end  
  def index
    	@user = User.find_by_id(current_user[:id])
	if @user.id<=5
		@goal = @user.goals.build 
      		@log_items_goals = @user.log_goal.paginate(page: params[:page])
	else
		redirect_to current_user, :notice => "You dont have the appropriate permission to view that page!"
	end
  end

   
  def create
     @goal = current_user.goals.build(goal_params)
       if @goal.save
           flash[:success] = "Goal Created"
           redirect_to(:back)
       else 
          @log_items_goals = []
       #render 'goals/goals'
       render 'new'
     end
  end
  def new
    @user = User.new
    if signed_in?
      @goal = current_user.goals.build 
      @log_items_goals = current_user.log_goal.paginate(page: params[:page])
    else
	redirect_to signin_path, :notice => "Please sign in first"
    end
  end

  def destroy
    @goal.destroy
    redirect_to(:back)
  end

private 
    def goal_params
	#params.fetch(:goal, {})
       params.require(:goal).permit(:description, :weight, :height) if params[:goal]
    end
    def correct_user
     @user = User.find(params[:id])
      redirect_to(current_user, :notice => "You tried to access a wrong link, please try again!") unless current_user?(@user)
    end
end
