class PlaySegment < ActiveRecord::Base
  belongs_to :start_event, class_name: 'Event'
  belongs_to :end_event, class_name: 'Event'

  def duration
    start_event.timestamp - end_event.timestamp
  end
end
