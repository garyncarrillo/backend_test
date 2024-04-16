class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :is_active
end
