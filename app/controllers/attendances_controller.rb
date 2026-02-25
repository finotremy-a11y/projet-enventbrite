class AttendancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:new, :index]
  before_action :is_admin?, only: [:index]

  def new
    # Déjà participant ?
    if @event.attendances.exists?(user: current_user)
      redirect_to @event, alert: "Tu participes déjà à cet événement."
      return
    end

    # Organisateur ?
    if current_user == @event.admin
      redirect_to @event, alert: "Tu es l'organisateur de cet événement."
      return
    end

    # Événement gratuit → inscription directe
    if @event.is_free?
      Attendance.create!(user: current_user, event: @event)
      redirect_to @event, notice: "Tu as rejoint cet événement gratuitement."
      return
    end

    # Sinon → afficher la page de paiement (vue new.html.erb)
  end

  def create
    event = Event.find(params[:event_id])

    # Sécurité : si gratuit, on ne passe pas par Stripe
    if event.is_free?
      Attendance.create!(user: current_user, event: event)
      redirect_to event_path(event), notice: "Tu as rejoint cet événement gratuitement."
      return
    end

    # Création de la session Stripe Checkout
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'eur',
          product_data: {
            name: event.title
          },
          unit_amount: event.price * 100 # conversion euros → centimes
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: success_attendances_url(event_id: event.id),
      cancel_url: cancel_attendances_url(event_id: event.id)
    )

    redirect_to session.url, allow_other_host: true
  end

  def success
    @event = Event.find(params[:event_id])

    # En vrai prod → webhook Stripe
    Attendance.create!(user: current_user, event: @event)

    redirect_to event_path(@event), notice: "Paiement réussi, tu es inscrit !"
  end

  def cancel
    @event = Event.find(params[:event_id])
    redirect_to event_path(@event), alert: "Paiement annulé."
  end

  def index
    @attendances = @event.attendances.includes(:user)
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def is_admin?
    unless current_user == @event.admin
      redirect_to root_path, alert: "Tu n'es pas autorisé ici."
    end
  end
end
