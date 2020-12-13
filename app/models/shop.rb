class Shop < ApplicationRecord
  has_many :stock
  has_many :books, through: :stock

  # Mark all books for current shop as sold out
  #
  # @param book_ids [Integer] list of book ids
  # @return [Integer] number of updated record
  #
  # rubocop:disable Rails/SkipsModelValidations
  def sold_out!(book_ids)
    stock.where(book_id: book_ids).where('amount > 0').update_all(amount: 0)
  end
  # rubocop:enable Rails/SkipsModelValidations
end
