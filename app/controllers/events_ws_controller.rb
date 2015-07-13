class EventsWsController < WebSocketsController
  def create
    Event.create_with_message(@app, message)
  end
end
