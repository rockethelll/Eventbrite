class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(current_user.id)
    @event_ids = Attendance.where(user_id: 1).pluck(:event_id)
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    redirect_to user_path(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :description)
  end
end
