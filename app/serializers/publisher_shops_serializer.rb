class PublisherShopsSerializer < ActiveModel::Serializer
  has_many :shops

  def shops
    instance_options[:shops]
  end

  class ShopSerializer < ActiveModel::Serializer
    attributes :id, :name

    attribute :books_sold_count do
      object.sold_count || 0
    end

    has_many :books_in_stock

    def books_in_stock
      instance_options[:books].select do |book|
        book.shop_id == object.id && book.amount.positive?
      end
    end

    class BookSerializer < ActiveModel::Serializer
      attributes :id, :title

      attribute :copies_in_stock do
        object.amount || 0
      end
    end
  end
end
