class EventTypeSerializer < ActiveModel::Serializer
  attributes :id, :key, :weight, :label, :app_id
end
