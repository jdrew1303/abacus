class Event < ActiveRecord::Base
  belongs_to :medium
  belongs_to :event_type

  def type
    event_type.key.to_sym
  end

  def weight
    read_attribute(:weight) || event_type.weight
  end

  def label
    eval(event_type.label)
  end

  def data
    @data ||= optional_data && JSON.parse(optional_data)
  end

  def data=(new_data)
    @data = new_data

    new_data = JSON.stringify(new_data)
    self.optional_data = new_data
  end

  def formatted_timestamp
    "#{(timestamp/60).to_i}:#{timestamp % 60 < 10 ? '0' : ''}#{timestamp % 60}"
  end

  def process_comment(text)
    # Adjust weight based on sentiment
    self.data = {text: text}
    self.weight = case Sentimental.new.get_sentiment(text)
      when :positive then 1
      when :negative then -1
      else 0
    end
  end

  def last_event(filter)
    event_types = filter.map {|k| medium.app.event_types.find_by(key: k)}
    Event.where(event_type: event_types, medium_id: medium_id, user_id: user_id).order(created_at: :desc).first
  end

  def self.create_with_message(app, message)
    message[:event_type_id] = EventType.find_by(app_id: app.id, key: message[:event_type]).id
    message[:medium_id] = Medium.create_with(url: message[:url], duration: message[:duration]).find_or_create_by(app_id: app.id, media_id: message[:media_id]).id

    @event = Event.new(event_type_id: message[:event_type_id],
                       user_id: message[:user_id],
                       medium_id: message[:medium_id],
                       timestamp: message[:timestamp])

    case @event.type
    when :comment
      @event.process_comment(message[:text])
      @event.save!
    when :pause
      # Get a list of all play/pause events for this medium, and make sure the last event was a play to pair with this pause
      @last_event = @event.last_event(['play', 'pause'])

      case @last_event.try(:type)
      when :play
        # save this pause event
        @event.save!

        if @event.timestamp - @last_event.timestamp > 0
          # Create play segment if longer than 0 seconds
          PlaySegment.create!(start_event_id: @last_event.id, end_event_id: @event.id)
        end
      when :pause
        # This is a heartbeat. Update the last pause heartbeat to have this new timestamp
        @last_event.timestamp = @event.timestamp
        @last_event.save!

        unless PlaySegment.find_by(end_event_id: @last_event.id).exists?
          # TODO what happens if this pause event is not part of a playsegment? assuming that shouldn't happen for now
          raise Exceptionally::ExpectationFailed.new('No play segment found for this pause')
        end
      else
        # The heart's beating, but the video was never played!
        raise Exceptionally::ExpectationFailed.new('No corresponding play event for this pause')
      end
    else
      @event.save!
    end

    @event
  end
end
