class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.belongs_to :shop, index: true
      t.belongs_to :book, index: true
      t.integer :amount

      t.timestamps
    end
  end
end
