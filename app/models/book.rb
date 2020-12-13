class Book < ApplicationRecord
  belongs_to :publisher
  has_many :stock
  has_many :shops, through: :stock
end
