class App < ActiveRecord::Base
  has_many :media
  has_many :event_types
  belongs_to :admin

  before_create :generate_key
  after_create :generate_events

  def generate_key
    self.key = "A#{admin_id}#{SecureRandom.hex(32)}"
  end

  def domain_is_whitelisted(domain)
    !!(domains =~ /^#{domain}$/)
  end

  private

  def generate_events
    # The default set of events an app will track
    # We can define and track more later, on a per-app basis
    event_types.create!(key: 'play', label: %q{'played the video'})
    event_types.create!(key: 'pause', label: %q{'paused the video'})
    event_types.create!(key: 'comment', label: %q{"commented#{weight > 0 ? ' positively' : weight < 0 ? ' negatively' : ''}"}, weight: 0)
    event_types.create!(key: 'volumechange', label: %q{"changed the volume to #{(data['volume']*100).to_i}"}, weight: 0)
    event_types.create!(key: 'like', label: %q{'liked the video'}, weight: 2)
    event_types.create!(key: 'unlike', label: %q{'unliked the video'}, weight: -2)
  end
end
