class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  end

  def show
    @user = User.find(current_user.id)
    @event_ids = Attendance.where(user_id: 1).pluck(:event_id)
  end

  def update
  end
end
