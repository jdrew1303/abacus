class MediumSerializer < ActiveModel::Serializer
  attributes :id, :media_id, :duration, :url, :app_id
end
