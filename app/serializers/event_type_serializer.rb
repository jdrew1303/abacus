class EventTypeSerializer < ActiveModel::Serializer
  attributes :key, :weight, :label, :app_id
end
