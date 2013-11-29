class GoalsController < ApplicationController
  def new
      @goal = Goal.new
  end
  
  def show
     @goals = Goal.all
  end
 
  def create
     @goal = Goal.new(goal_params)
       if @goal.save
          
          flash[:success] = "Welcome to the Get Healthy Website!"
           redirect_to @goal
       else 
          render 'new'
     end
  end

private 
    def goal_params
       params.require(:goal).permit(:Weight)
    end
end
