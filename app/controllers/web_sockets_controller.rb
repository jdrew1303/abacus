class WebSocketsController < WebsocketRails::BaseController
  before_filter :authenticate_app

  around_filter :exceptionally_wrapper

  def exceptionally_wrapper
    yield
  rescue Exceptionally::Error => error
    exceptionally_handler(error)
  end

  def authenticate_app
    authenticate_app_with_key_and_origin(event.channel, message[:origin])
  end

  def render_error(message, status)
    trigger_failure({error: message, status: status})
  end
end
