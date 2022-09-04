class Country
  include ActiveModel::API

  attr_accessor :name, :code, :native, :emoji, :capital, :currency
end