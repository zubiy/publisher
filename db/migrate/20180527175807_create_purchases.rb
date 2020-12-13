class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.belongs_to :shop, index: true
      t.belongs_to :book, index: true

      t.timestamps
    end
  end
end
