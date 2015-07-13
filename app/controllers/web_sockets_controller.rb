class WebSocketsController < WebsocketRails::BaseController
  before_filter :authenticate_app

  around_filter :exceptionally_wrapper

  def exceptionally_wrapper
    yield
  rescue Exception => error
    exceptionally_handler(error)
  rescue ArgumentError => error2
    exceptionally_handler(error2)
  rescue Exceptionally::Error => error3
    exceptionally_handler(error3)
  end

  def authenticate_app
    @app = authenticate_app_with_key_and_origin(message[:app_key], message[:origin])
  end

  def render_error(message, status)
    trigger_failure({message: message, status: status})
  end
end
