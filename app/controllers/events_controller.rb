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
    @user = User.all
  end

  def create
    event = Event.new(event_params)
    event.picture.attach(params[:picture])
    event.update(admin_id: current_user.id)
    if event.save!
      flash[:success] = 'Événement crée'
      redirect_to event_path(event)
    else
      flash[:error] = 'Erreur : impossible de sauvegarder l"événement'
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location, :picture)
  end
end
