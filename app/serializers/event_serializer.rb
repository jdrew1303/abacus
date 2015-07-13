class EventSerializer < ActiveModel::Serializer
  attributes :type, :label, :weight, :timestamp, :formatted_timestamp, :user_id
  has_one :medium
end
