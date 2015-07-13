class EventsController < ApplicationController
  before_action :authenticate_app

  # GET /events
  # GET /events.json
  def index
    @events = @app.media.includes(:events).find_by(media_id: params[:media_id]).events

    render json: @events
  end

  # POST /events
  # POST /events.json
  # We pass {event_type: "play", meda_id: 232, duration: 455, user_id: 4, timestamp: 76}
  def create
    @event = Event.create_with_message(@app, params)

    render json: @event, status: :created
  end
end
