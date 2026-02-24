class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all.order(start_date: :asc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user   # ← IMPORTANT

    if @event.save
      redirect_to @event, notice: "Événement créé avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(
      :start_date,
      :duration,
      :title,
      :description,
      :price,
      :location
    )
  end
end
