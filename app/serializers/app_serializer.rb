class AppSerializer < ActiveModel::Serializer
  attributes :name, :key, :domains, :admin_id
end
