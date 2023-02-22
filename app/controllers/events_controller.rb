class EventsController < ApplicationController
  def index
    @event = Event.all
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = 'Potin sauvegardé'
      redirect_to event_path(@event.id)
    else
      flash[:alert] = 'Erreur : impossible de sauvegarder le potin'
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
