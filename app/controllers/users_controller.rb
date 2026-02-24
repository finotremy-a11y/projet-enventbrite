class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def show
    @user = User.find(params[:id])
    @events = @user.events_as_admin
  end

  private

  def correct_user
    unless current_user.id == params[:id].to_i
      redirect_to root_path, alert: "Accès non autorisé."
    end
  end
end
