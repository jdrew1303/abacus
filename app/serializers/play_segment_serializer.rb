class PlaySegmentSerializer < ActiveModel::Serializer
  attributes :id
  has_one :start_event
  has_one :end_event
end
