class Stock < ApplicationRecord
  belongs_to :shop
  belongs_to :book
end
