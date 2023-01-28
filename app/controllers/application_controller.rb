class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_locale

  include Pundit::Authorization

  # Pundit: white-list approach.
  after_action :verify_authorized, except: [:index, :not_found], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
    redirect_to(root_path)
  end

  private

  def set_locale
    I18n.locale = :fr # Or whatever logic you use to choose.
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
