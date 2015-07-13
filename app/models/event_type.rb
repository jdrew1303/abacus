class EventType < ActiveRecord::Base
  belongs_to :app
  has_many :events
end
