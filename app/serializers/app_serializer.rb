class AppSerializer < ActiveModel::Serializer
  attributes :id, :name, :key, :domains, :admin_id
end
