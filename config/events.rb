WebsocketRails::EventMap.describe do
  namespace :event do
    subscribe :create, :to => EventsWsController, :with_method => :create
  end
end
