class EventsController < ApplicationController
  def index
    @event = Event.all
  end

  def new
    @event = Event.new
    @admin_id = current_user.id
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    puts '-' * 60
    event = Event.new(event_params)
    event.update(admin_id: current_user.id)
    if event.save!
      flash[:success] = 'Événement crée'
      redirect_to event_path(event)
    else
      flash[:error] = 'Erreur : impossible de sauvegarder l"événement'
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
