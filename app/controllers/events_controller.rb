class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :check_admin!, only: [:edit, :update, :destroy]

  def index
    @events = Event.all.order(start_date: :asc)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.admin = current_user

    if @event.save
      redirect_to @event, notice: "Événement créé avec succès !"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Événement mis à jour avec succès !"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Événement supprimé."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def check_admin!
    unless current_user == @event.admin
      redirect_to root_path, alert: "Tu n'es pas autorisé à modifier cet événement."
    end
  end

  def event_params
    params.require(:event).permit(
      :start_date,
      :duration,
      :title,
      :description,
      :price,
      :location,
      :photo
    )
  end
end
