class EventsWsController < WebSocketsController
  def create
    @event = Event.create_with_message(@app, message)

    trigger_success({message: "#{@event.label} at #{@event.formatted_timestamp}", status: 201})
  end
end
