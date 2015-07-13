class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_app
    authenticate_app_with_key_and_origin(params[:app_key], params[:origin])
  end

  def authenticate_app_with_key_and_origin(key, origin)
    @app = App.find_by_key(key)

    raise Exceptionally::Unauthorized.new('Invalid app key for origin') unless @app.try(:domain_is_whitelisted, origin)

    @app
  end
end
