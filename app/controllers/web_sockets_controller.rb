class WebSocketsController < WebsocketRails::BaseController
  before_filter :authenticate_app

  around_filter :exceptionally_wrapper

  def exceptionally_wrapper
    yield
  rescue Error => error
    exceptionally_handler(error)
  end

  def authenticate_app
    @app = authenticate_app_with_key_and_origin(message[:app_key], message[:origin])
  end

  def render_error(message, status)
    trigger_failure({message: message, status: status})
  end
end
