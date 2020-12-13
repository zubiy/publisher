class Shops
  def self.sort_shop(publisher)
    query = <<~SQL
      SELECT sh.*,
       p.sold_count
      FROM shops sh
        INNER JOIN (
          SELECT DISTINCT s.shop_id
          FROM stocks s
            INNER JOIN books b ON b.id = s.book_id
          WHERE b.publisher_id = #{publisher.id}
            AND s.amount > 0
                   ) st ON st.shop_id = sh.id
        LEFT JOIN (
          SELECT p.shop_id,
                 count(*) AS sold_count
          FROM purchases p
            INNER JOIN books b ON b.id = p.book_id
          WHERE b.publisher_id = #{publisher.id}
          GROUP BY p.shop_id
                  ) p ON p.shop_id = sh.id
      ORDER BY p.sold_count
    SQL

    Shop.find_by_sql(query)
  end
  # rubocop:enable Metrics/MethodLength
end
#class PublisherShopsQuery
  # extend SingleForwardable

  # delegate call: :new

  # def call(publisher_id)
  # PublisherShop.
  #  includes(shop: {shop_books: :book}).
  #  where(publisher_shops: {publisher_id: publisher_id}, books: {publisher_id: publisher_id}).
  #  where('shop_books.copies_in_stock > 0').
  #   order('publisher_shops.books_sold_count DESC, shop_books.copies_in_stock DESC').limit 1000
  #end
  #end